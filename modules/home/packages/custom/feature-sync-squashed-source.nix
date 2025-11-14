{ pkgs, ... }:
let
  feature-sync-squashed-source = pkgs.writeShellScriptBin "feature-sync-squashed-source" ''
    set -e

    usage() {
        echo "Usage: ''$0 <main-branch> <feature-branch> [--check]"
        echo
        echo "Synchronize the first commit of <feature-branch> with a squashed <main-branch>."
        echo "Or, with --check, only compare the first commit without modifying anything."
        echo
        echo "Options:"
        echo "  -h, --help    Show this help message and exit"
        echo "  --check       Only check if the first commit matches main"
    }

    # Parse arguments
    CHECK_ONLY=false
    for arg in "''$@"; do
        case "''$arg" in
            -h|--help)
                usage
                exit 0
                ;;
            --check)
                CHECK_ONLY=true
                ;;
        esac
    done

    # Remove recognized flags from ''$@
    ARGS=()
    for arg in "''$@"; do
        if [[ "''$arg" != "--check" && "''$arg" != "-h" && "''$arg" != "--help" ]]; then
            ARGS+=("''$arg")
        fi
    done

    if [[ ''${#ARGS[@]} -ne 2 ]]; then
        echo "Error: exactly 2 branch arguments required."
        usage
        exit 1
    fi

    MAIN_BRANCH="''${ARGS[0]}"
    FEATURE_BRANCH="''${ARGS[1]}"

    # Check only mode
    if ''$CHECK_ONLY; then
        git diff --color "''$(git rev-list --max-parents=0 "''$FEATURE_BRANCH")"^{tree} "''$MAIN_BRANCH"^{tree}
        if [[ ''$? -eq 0 ]]; then
            echo -e "\nSUCCESS: check completed"
            exit 0
        else
            echo -e "\nFAILURE: check completed"
            exit 1
        fi
    fi

    check_clean_worktree() {
      local dirty_count
      dirty_count=$(git status --porcelain=v1 2>/dev/null | wc -l)
        if [[ "$dirty_count" -ne 0 ]]; then
            echo -e "\nFAILURE: Working tree is not clean. Please commit or stash changes before running this script."
            exit 1
        fi
    }

    # --- Normal sync workflow ---

    check_clean_worktree

    # Ensure we start from the main branch
    git checkout "''$MAIN_BRANCH"

    # Create a temporary squash of main
    git checkout --orphan temp
    git commit -m "''$MAIN_BRANCH (squashed)"

    # Rebase only the very first commit in the feature branch onto temp
    git rebase --onto temp "''$(git rev-list --max-parents=0 "''$FEATURE_BRANCH")" "''$FEATURE_BRANCH"

    # Clean up temp branch
    git branch -D temp

    # Always show diff
    git diff --color "''$(git rev-list --max-parents=0 "''$FEATURE_BRANCH")"^{tree} "''$MAIN_BRANCH"^{tree}

    # Always print simple success/failure based on exit code
    if [[ ''$? -eq 0 ]]; then
        echo -e "\nSUCCESS: sync completed"
    else
        echo -e "\nFAILURE: sync completed"
    fi
  '';
in
{
  home.packages = [
    feature-sync-squashed-source
  ];

  programs.git.aliases.feature-sync-squashed-source = "!${feature-sync-squashed-source}/bin/feature-sync-squashed-source";

}
