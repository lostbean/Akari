{ pkgs, ... }:
let
  fetch-clean-md = pkgs.callPackage ./tools/get_clean_mardown.nix { };
in
{
  plugins.codecompanion = {
    enable = true;

    settings = {
      adapters = {
        anthropic.__raw = ''
          function()
            return require("codecompanion.adapters").extend("anthropic", {
              schema = {
                model = {
                  default = "claude-3-7-sonnet-20250219"
                }
              }
            })
          end
        '';
        openai.__raw = ''
          function()
            return require("codecompanion.adapters").extend("openai", {
              schema = {
                model = {
                  default = "o1-mini"
                }
              }
            })
          end
        '';
        gemini.__raw = ''
          function()
            return require("codecompanion.adapters").extend("gemini", {
              schema = {
                model = {
                  default = "gemini-2.5-pro-preview-05-06"
                }
              }
            })
          end
        '';
      };

      strategies = {
        chat.adapter = "gemini";
        inline.adapter = "gemini";
        agent.adapter = "gemini";
      };

      strategies.chat = {
        variables = {
          # Pending fix be available in nixpkgs: https://github.com/Aider-AI/aider/issues/527
          "git diff" = {
            callback.__raw = ''
              function()
                return string.format(
                  [[
                  ```diff
                  %s
                  ```
                  ]],
                  vim.fn.system("git diff $(git merge-base --fork-point main)")
                )
              end
            '';
            description = "Share the current git diff with the LLM";
            opts = {
              contains_code = true;
              hide_reference = true;
            };
          };
        };
        slash_commands = {
          "fetch-as-md" = {
            description = "List git files";
            callback.__raw = ''
              function(chat)
                vim.ui.input(
                  {prompt='Enter a URL: '},
                  function(url)
                    local id = "<url>" .. url .. "</url>"
                    local doc = vim.fn.system("${fetch-clean-md}/bin/fetch-clean-md " .. url)

                    if vim.v.shell_error ~= 0 then
                       vim.notify("Error executing fetch-clean-md: " .. doc, vim.log.levels.ERROR, { title = "CodeCompanion" })
                       return ""
                    end

                    local config = require("codecompanion.config")

                    local content = string.format([[%s

              <content>
              %s
              </content>]], "Here is the output from " .. url .. " that I'm sharing with you:", doc)

                    chat:add_message({
                      role = config.constants.USER_ROLE,
                      content = content,
                    }, { reference = id, visible = false })

                    chat.references:add({
                      source = "slash_command",
                      name = "fetch-as-md",
                      id = id,
                    })

                    return vim.notify("Added " .. url .. " to the chat", vim.log.levels.INFO, { title = "CodeCompanion" })
                  end)
              end
            '';
            opts = {
              contains_code = false;
            };
          };
        };
      };

      prompt_library = {
        "Describe PR" = {
          strategy = "chat";
          description = "Create a PR description between the current brancn and main";
          opts = {
            index = 5;
            is_default = true;
            is_slash_cmd = false;
            auto_submit = true;
            user_prompt = false;
            stop_context_insertion = true;
          };
          prompts = [
            {
              role = "user";
              content.__raw = ''
                function()
                  return string.format(
                    [[
                    Generated a PR description based on:
                    ```diff
                    %s
                    ```

                    and based on these commint messages:
                    %s
                    ]],
                    vim.fn.system("git diff $(git merge-base --fork-point main)"),
                    vim.fn.system("git log ...main --oneline --no-merges")
                  )
                end
              '';
              opts = {
                visible = false;
                tag = "system_tag";
              };
            }
          ];
        };

        "Continue Implementation" = {
          strategy = "chat";
          description = "Continue Implementation based on the current git diff";
          opts = {
            index = 5;
            is_default = true;
            is_slash_cmd = false;
            auto_submit = false;
            user_prompt = false;
            stop_context_insertion = true;
          };
          prompts = [
            {
              role = "user";
              content.__raw = ''
                function(context)
                  local diagnostics = require("codecompanion.helpers.actions").get_diagnostics(
                    context.start_line,
                    context.end_line,
                    context.bufnr
                  )

                  local concatenated_diagnostics = ""
                  for i, diagnostic in ipairs(diagnostics) do
                    concatenated_diagnostics = concatenated_diagnostics
                      .. i
                      .. ". Issue "
                      .. i
                      .. "\n  - Location: Line "
                      .. diagnostic.line_number
                      .. "\n  - Buffer: "
                      .. context.bufnr
                      .. "\n  - Severity: "
                      .. diagnostic.severity
                      .. "\n  - Message: "
                      .. diagnostic.message
                      .. "\n"
                  end

                  local buf_utils = require("codecompanion.utils.buffers")


                  return string.format(
                    [[
                I want you to act as a senior %s developer. Your goal is to continue the propagating the modifications from where I stopped.
                Here is diff of what I have done so far:
                ```diff
                %s
                ```

                You may also find it useful to see the warnings/errors from the LSP:
                %s


                And this is the code we are working next:
                ```%s
                %s
                ```

                Now, you update the following code to make it fully functional and up to date with previous modifications. Provade all code modifications as diff format.

                    ]],
                    context.filetype,
                    vim.fn.system("git diff --no-ext-diff HEAD"),
                    concatenated_diagnostics,
                    context.filetype,
                    buf_utils.get_content(context.bufnr)
                  )
                end
              '';
              opts = {
                visible = false;
                tag = "system_tag";
              };
            }
          ];
        };
      };
      opts = {
        log_level = "TRACE";
        send_code = true;
        use_default_actions = true;
        use_default_prompts = true;
      };
    };
  };

  keymaps = [
    {
      action = "<cmd>CodeCompanionActions<CR>";
      key = "<leader>ac";
      options.desc = "CodeCompanion Actions";
      mode = [
        "v"
        "n"
      ];
    }
  ];
}
