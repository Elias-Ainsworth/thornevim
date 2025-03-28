{
  lib,
  maxi ? false,
  transparency ? false,
  ...
}:
let
  mkTrigger = mode: keys: { inherit mode keys; };
  mkClue = mode: keys: desc: { inherit mode keys desc; };
  # mkPattern =
  #   pattern: # lua
  #   "
  #   function(buf_id)
  #       local commentstring = vim.bo[buf_id].commentstring
  #           if not commentstring or commentstring == '' then
  #               return nil
  #           end
  #           -- Escape special characters in the comment string
  #           local escaped_commentstring = vim.pesc(commentstring):gsub('%%s', '')
  #           -- Pattern to match the comment string followed by TODO and optional colon
  #           return string.format('%s%s:?', escaped_commentstring, '${pattern}')
  #   end,
  #   ";
  # mkHighlighter = pattern: group: {
  #   inherit group;
  #   pattern = mkPattern pattern;
  # };
in
{
  vim = {
    # You might want to add a custom Lua configuration
    mini = lib.mkIf (!maxi) {
      ai.enable = true;
      bracketed.enable = true;
      bufremove.enable = true;
      clue = {
        enable = true;
        setupOpts = {
          clues = lib.mkForce [
            {
              miniclue.gen_clues.builtin_completion.enable = true;
              miniclue.gen_clues.g = true;
              miniclue.gen_clues.marks = true;
              miniclue.gen_clues.registers = true;
              miniclue.gen_clues.windows = true;
              miniclue.gen_clues.z = true;
            }
            (mkClue "n" "gn" "I[N]it")

            (mkClue "n" "<leader>b" "[B]uffer")
            (mkClue "n" "<leader>bm" "[M]ove")
            (mkClue "n" "<leader>bs" "[S]ort")

            (mkClue "n" "<leader>G" "[G]it")

            (mkClue "n" "<leader>g" "[G]itsigns")
            (mkClue "n" "<leader>gc" "[C]hoose")
            (mkClue "n" "<leader>gd" "[D]iff")
            (mkClue "n" "<leader>gl" "Blame [L]ine")
            (mkClue "n" "<leader>gp" "[P]review Hunk")
            (mkClue "n" "<leader>gr" "[R]eset")
            (mkClue "n" "<leader>gs" "[S]tage")
            (mkClue "n" "<leader>gt" "[T]oggle")
            (mkClue "v" "<leader>g" "[G]itsigns")
            (mkClue "v" "<leader>gr" "[R]eset")
            (mkClue "v" "<leader>gs" "[S]tage")

            (mkClue "n" "<leader>l" "[L]sp")
            (mkClue "n" "<leader>la" "Code [A]ction")
            (mkClue "n" "<leader>ld" "[D]iagnostic [trouble]")
            (mkClue "n" "<leader>le" "Diagnostic [float]")
            (mkClue "n" "<leader>lf" "[F]ormat")
            (mkClue "n" "<leader>lg" "[G]oto")
            (mkClue "n" "<leader>lH" "[H]ighlight")
            (mkClue "n" "<leader>lh" "[H]over")
            (mkClue "n" "<leader>ln" "Re[N]ame")
            (mkClue "n" "<leader>lo" "Activate LSP [O]n Cursor")
            (mkClue "n" "<leader>lr" "[R]eferences [trouble]")
            (mkClue "n" "<leader>lS" "[S]ymbols")
            (mkClue "n" "<leader>ls" "[S]ignature help")
            (mkClue "n" "<leader>lt" "[T]oggle")
            (mkClue "n" "<leader>lw" "[W]orkspace")

            (mkClue "n" "<leader>n" "[N]eorg")
            (mkClue "n" "<leader>nw" "[W]orkpace")

            (mkClue "n" "<leader>p" "[P]ick")

            (mkClue "n" "<leader>t" "[T]odo")
            (mkClue "n" "<leader>tq" "[Q]uickFix")
            #TODO: Make this remap.
            # (mkClue "n" "<leader>tt" "[T]rouble")

            (mkClue "n" "<leader>x" "Trouble")
            (mkClue "n" "<leader>xl" "[L]OCList")
            (mkClue "n" "<leader>xq" "[Q]uickFix")
            (mkClue "n" "<leader>xs" "[S]ymbols")

            (mkClue "n" "<localleader>c" "[C]ode")
            (mkClue "n" "<localleader>d" "[D]ate")
            (mkClue "n" "<localleader>l" "[L]ist")
            (mkClue "n" "<localleader>t" "[T]oggle")
            (mkClue "n" "<localleader>n" "[N]ew")
          ];
          triggers = [
            (mkTrigger "n" "<leader>")
            (mkTrigger "x" "<leader>")
            (mkTrigger "v" "<leader>")

            (mkTrigger "n" "<localleader>")
            (mkTrigger "x" "<localleader>")
            (mkTrigger "v" "<localleader>")

            (mkTrigger "n" "<C-W>")
            (mkTrigger "x" "<C-W>")
            (mkTrigger "v" "<C-W>")

            (mkTrigger "n" "g")
            (mkTrigger "x" "g")
            (mkTrigger "v" "g")

            (mkTrigger "n" "z")
            (mkTrigger "x" "z")

            (mkTrigger "n" "'")
            (mkTrigger "x" "'")

            (mkTrigger "n" "`")
            (mkTrigger "x" "`")

            (mkTrigger "n" ''"'')
            (mkTrigger "x" ''"'')

            (mkTrigger "c" "<C-R>")
            (mkTrigger "i" "<C-R>")
          ];
          window.delay = 100;
        };
      };
      comment.enable = true;
      #TODO: Currently unavailable in nvf.
      # cursorword.enable = true;
      extra.enable = true;
      files.enable = true;
      hipatterns = {
        enable = true;
        setupOpts = {
          highlighters = {
            # fixme = mkHighlighter "FIXME" "MiniHipatternsFixme";
            # hack = mkHighlighter "HACK" "MiniHipatternsHack";
            # todo = mkHighlighter "TODO" "MiniHipatternsTodo";
            # note = mkHighlighter "NOTE" "MiniHipatternsNote";

            hex_color = lib.generators.mkLuaInline ''require("mini.hipatterns").gen_highlighter.hex_color()'';

            # TODO: Get this to work.
            # base16_color =
            #   lib.generators.mkLuaInline # lua
            #     ''
            #       {
            #         pattern = "base0[%dA-F]",
            #         group = function(_, match)
            #           local words = ${lib.nvim.lua.toLuaObject colorScheme'}
            #           local hex = words[match]
            #           if hex == nil then return nil end
            #           return MiniHipatterns.compute_hex_color_group(hex, bg)
            #         end,
            #       }
            #     '';
          };
        };
      };
      icons.enable = true;
      indentscope.enable = true;
      jump.enable = true;
      jump2d = {
        enable = true;
        setupOpts = {
          mappings.start_jumping = "<CR>";

        };
      };
      move.enable = true;
      notify = {
        enable = true;
        setupOpts = lib.mkIf transparency {
          window.winblend = 0;
        };
      };
      operators.enable = true;
      pairs.enable = true;

      #TODO: Make a picker to search through todo-comments.
      pick.enable = true;
      snippets.enable = true;
      splitjoin.enable = true;
      starter = {
        enable = true;
        setupOpts = {
          header =
            #  ''
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢡⢀⣶⣶⣶⣶⡿⠷⠖⠒⠁⠀⠀⠀⠀⠀⠀⣿⠀⠀⠉⠛⢿⣄⠀⠀⠀⠀⠀⠀⢸⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⣷⣿⣿⣵⡀⢾⣿⣶⣿⣶⣶⣶⡢⠑⢄⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢸⠿⠛⣉⣤⣴⣒⣮⠽⣭⣯⣥⣉⣌⣉⡅⢻⡇⠀⠀⠀⠀⠙⢦⡀⡠⠤⢄⡀⠸⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⢰⣿⣿⣿⣿⣧⠘⣿⣿⣿⣿⣿⣿⣟⣄⡀⠀⡀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡡⣴⣽⣾⡻⠮⠛⠋⠉⠉⠀⠀⠀⠀⠀⠀⠘⠿⠄⠀⠀⢀⣀⠈⣷⣌⠿⣷⣾⣄⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢀⣿⣿⣿⣿⣿⣿⠀⢻⣿⣿⣿⣿⣿⣿⣷⣅⠀⠈⠄⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢔⣥⣞⠟⢊⣡⣤⣶⣶⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⠶⠶⠒⠦⠤⠅⣈⡃⠀⠘⣽⣿⡀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣼⣿⣿⣿⣿⣿⣿⠀⠈⣿⣿⣿⣿⣿⣿⣏⡁⢀⠀⠀⢂⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢔⢵⠾⢋⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣦⣤⣄⣉⠐⠘⣿⣧⠘⣿⣿⣿⣿⣿⣿⣿⣿⡟⢠⣿⣿⣿⣿⣿⣿⣿⠀⠀⢹⣿⣿⣿⣿⣟⣷⡿⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢣⡖⢁⣴⣿⣿⣿⣿⣿⣿⠿⠟⠛⠛⠉⠉⠉⠉⠉⠉⠉⠉⠙⠛⠻⠿⣏⣉⠉⠉⠙⠚⠳⢦⠘⣿⣇⠹⣿⣿⣿⣿⣿⣿⣿⠃⣾⣿⣿⣿⣿⣿⣿⡿⠀⠀⠈⣿⣿⣿⣿⣿⡟⡗⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢱⠋⣴⣿⣿⣿⣿⡿⠛⠉⠀⣀⣠⣴⣶⣿⡿⠛⠏⣀⣴⣿⣿⣶⣶⣦⠄⢀⣈⠙⠢⡀⢤⣄⡀⠀⠸⣿⡆⢻⣿⣿⣿⣿⣿⡏⢰⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⢿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢣⠇⣼⣿⣿⣿⡿⠋⠀⣠⣴⣾⣿⣿⣿⣿⡟⠀⡁⢾⣿⣿⣿⣿⣿⣿⡟⠀⢰⣿⣿⣶⣤⡀⢻⣿⣷⣦⠹⣿⡄⢻⣿⣿⣿⡿⠀⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⢸⣿⣿⣿⣿⡣⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡜⢠⣿⣿⣿⡏⢀⣴⣿⣿⣿⣿⣿⣿⣿⠟⡁⢮⡇⣸⣿⣿⣿⣿⣿⣿⢃⠀⢸⣿⣿⣿⣿⣿⣤⣿⣿⣿⣇⢻⣿⡄⠻⣿⡿⠁⢠⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠸⣷⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⡜⢿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⣴⣾⣧⣘⣴⣿⣿⣿⣿⣿⣿⣿⣸⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⢿⣷⡀⠈⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⢀⢿⣯⣿⣿⡖⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⣽⡿⢤⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⣡⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣷⠘⣿⣷⡀⠀⠀⣸⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⢀⢼⣿⣿⡿⢈⠁⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣔⣽⠋⢠⣾⣿⣿⣿⣿⡟⣋⠉⠀⢶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⡇⢻⣿⣇⠀⠀⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⢀⣴⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⣪⡾⠁⣰⣿⠋⣽⣿⡟⢻⣿⣿⣷⡀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢏⣴⣾⣿⣿⠘⣿⣿⠀⢀⣿⣿⣿⣿⡿⠁⠀⠀⠀⠐⠛⠛⠛⢉⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⠟⢡⣾⡾⠁⣾⣿⣿⡇⠀⠹⣿⣿⣿⣦⡈⠻⣿⣿⣿⣿⣿⠛⢿⣿⣿⣿⣿⣿⣿⡟⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⢻⠇⠀⢸⣿⠿⢋⣡⣤⠶⠶⠶⠾⠯⠿⢿⣻⣻⠷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⢀⣤⣲⣿⣿⠟⢁⢴⣿⡟⠀⢰⣿⣿⣿⣿⣆⠀⠈⠺⢟⢿⣾⣦⡙⢿⣿⣿⡇⣸⠘⣿⣿⣿⣿⣿⣿⡇⠁⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠛⣁⣈⣉⣥⣤⣤⣤⣤⣤⣤⣤⢤⢄⣀⣈⡉⠀⠒⠀⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⡀⢔⣼⣷⡿⡿⠕⣁⢴⣿⡟⡝⠀⠀⢸⢹⣿⣿⣿⣿⣿⣢⣀⠀⠑⠻⢟⡿⣶⢌⠻⣇⢹⠀⣿⣿⣿⣿⣿⣿⣿⡀⠀⣿⣿⣿⣿⣿⣿⣿⠿⢋⣩⣥⣤⣖⣶⣶⣿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣒⣀⡀⠈⠁⠀⠀⠀⠀⠀⠀⠀
            #   ⠀⢀⠔⢹⡘⠛⢟⠜⠊⢀⢌⢕⣻⢏⠎⠀⠀⠀⢸⢹⣿⣿⡿⣿⡿⢿⢷⡯⡒⡠⢄⣈⠑⠒⠁⠂⠀⠠⠿⣿⣿⣿⣿⣿⣿⣇⣀⣿⣿⣿⡿⠿⠛⡡⣺⣿⣿⣿⣿⣏⣁⣀⣀⣀⡀⣀⢀⢀⣀⣀⣀⣀⣀⣀⠠⢤⠤⠤⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            #   ⠀⠈⠐⠀⠡⠐⠁⠀⠀⠂⠠⠬⠉⠎⠀⠀⠀⠀⠀⠘⠉⠉⢐⠧⠱⠀⠢⡨⠩⠛⠆⠤⢋⡉⠒⠒⠀⠤⠄⠄⠀⣈⣉⣉⣉⣉⡉⠩⠄⠀⠀⠠⣪⣿⣿⣿⢿⣿⡿⠿⡷⣾⣾⣿⣿⠿⣿⣿⣿⣦⡤⠖⠻⠾⡅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠈⠂⠄⡀⠀⠀⠀⠀⠉⠉⠉⠀⠀⠀⠀⢈⡉⠀⠠⠀⡀⠌⠂⠔⠑⠋⠋⠉⠉⠛⠛⢫⠂⠫⠉⠟⠓⠋⠂⠋⠁⠉⠉⠁⢀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠄⠀⠀⠀⠀⠁⠀⠀⠤⠄⠐⠀⠀⠀⠀⠌⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            #   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            # ''

            # ''
            #
            #                                                
            #         ████ ██████           █████      ██
            #        ███████████             █████ 
            #        █████████ ███████████████████ ███   ███████████
            #       █████████  ███    █████████████ █████ ██████████████
            #      █████████ ██████████ █████████ █████ █████ ████ █████
            #    ███████████ ███    ███ █████████ █████ █████ ████ █████
            #   ██████  █████████████████████ ████ █████ █████ ████ ██████
            #
            # '';

            # TODO: who are you
            # ''
            #    .--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--.
            #   / .. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \
            #   \ \/\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ \/ /
            #    \/ /`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'\/ /
            #    / /\                                                                                                                    / /\
            #   / /\ \      ███        ▄█    █▄     ▄██████▄     ▄████████ ███▄▄▄▄      ▄████████       ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄    / /\ \
            #   \ \/ /  ▀█████████▄   ███    ███   ███    ███   ███    ███ ███▀▀▀██▄   ███    ███      ███    ███ ███  ▄██▀▀▀███▀▀▀██▄  \ \/ /
            #    \/ /      ▀███▀▀██   ███    ███   ███    ███   ███    ███ ███   ███   ███    █▀       ███    ███ ███▌ ███   ███   ███   \/ /
            #    / /\       ███   ▀  ▄███▄▄▄▄███▄▄ ███    ███  ▄███▄▄▄▄██▀ ███   ███  ▄███▄▄▄          ███    ███ ███▌ ███   ███   ███   / /\
            #   / /\ \      ███     ▀▀███▀▀▀▀███▀  ███    ███ ▀▀███▀▀▀▀▀   ███   ███ ▀▀███▀▀▀          ███    ███ ███▌ ███   ███   ███  / /\ \
            #   \ \/ /      ███       ███    ███   ███    ███ ▀███████████ ███   ███   ███    █▄       ███    ███ ███  ███   ███   ███  \ \/ /
            #    \/ /       ███       ███    ███   ███    ███   ███    ███ ███   ███   ███    ███      ███    ███ ███  ███   ███   ███   \/ /
            #    / /\      ▄████▀     ███    █▀     ▀██████▀    ███    ███  ▀█   █▀    ██████████       ▀██████▀  █▀    ▀█   ███   █▀    / /\
            #   / /\ \                                          ███    ███                                                              / /\ \
            #   \ \/ /                                                                                                                  \ \/ /
            #    \/ /                                                                                                                    \/ /
            #    / /\.--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--./ /\
            #   / /\ \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \/\ \
            #   \ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `' /
            #    `--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'
            # '';

            ''
               .--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--.
              / .. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \
              \ \/\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ \/ /
               \/ /`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'\/ /
               / /\                                                                                    / /\
              / /\ \ ████████╗██╗  ██╗ ██████╗ ██████╗ ███╗   ██╗███████╗    ██╗   ██╗██╗███╗   ███╗  / /\ \
              \ \/ / ╚══██╔══╝██║  ██║██╔═══██╗██╔══██╗████╗  ██║██╔════╝    ██║   ██║██║████╗ ████║  \ \/ /
               \/ /     ██║   ███████║██║   ██║██████╔╝██╔██╗ ██║█████╗      ██║   ██║██║██╔████╔██║   \/ /
               / /\     ██║   ██╔══██║██║   ██║██╔══██╗██║╚██╗██║██╔══╝      ╚██╗ ██╔╝██║██║╚██╔╝██║   / /\
              / /\ \    ██║   ██║  ██║╚██████╔╝██║  ██║██║ ╚████║███████╗     ╚████╔╝ ██║██║ ╚═╝ ██║  / /\ \
              \ \/ /    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝      ╚═══╝  ╚═╝╚═╝     ╚═╝  \ \/ /
               \/ /                                                                                    \/ /
               / /\.--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--..--./ /\
              / /\ \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \.. \/\ \
              \ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `'\ `' /
               `--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'`--'
            '';

        };

      };
      statusline.enable = true;
      surround.enable = true;
      tabline.enable = true;
      trailspace.enable = true;
    };
  };
}
