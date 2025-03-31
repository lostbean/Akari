{
  pkgs ? import <nixpkgs> { },
}:
let
  clean-filter = pkgs.writeText "clean-filter.lua" ''
    -- clean_doc.lua
    function Image(el)
      -- Remove all image elements by returning an empty inline element
      return {}
    end

    function RawBlock(el)
      -- Remove all raw HTML blocks
      return {}
    end

    function RawInline(el)
      -- Remove all raw HTML inlines
      return {}
    end

    function Div(el)
      -- Remove all classes from Div elements
      el.attr = {}
      return el
    end

    function Span(el)
      -- Remove all classes from Span elements
      el.attr = {}
      return el
    end

    function Meta(el)
      -- Remove all metadata
      return {}
    end

    function Link(el)
      el.attr = {}
    end
  '';
in
pkgs.writeShellScriptBin "fetch-clean-md" ''
  ${pkgs.pandoc}/bin/pandoc -f html -t markdown-raw_html-native_divs-native_spans-fenced_divs-bracketed_spans --lua-filter=${clean-filter} "$1"
''
