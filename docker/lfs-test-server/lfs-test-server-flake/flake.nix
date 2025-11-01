{
  description = "lfs-test-server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        # "x86_64-darwin" # 64-bit Intel macOS
        # "aarch64-darwin" # 64-bit ARM macOS
      ];
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs allSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      packages = forAllSystems (
        { pkgs }:
        {
          default = pkgs.buildGoModule {
            pname = "lfs-test-server";
            version = "unstable";
            modSha256 = null;
            # subPackages = [ "ziti" ];
            src = pkgs.fetchFromGitHub {
              owner = "git-lfs";
              repo = "lfs-test-server";
              rev = "b3e9808d367e52510f4111d6bf14657c7ae2856c";
              hash = "sha256-bvYiI+Md1QVxl0mQjmp21ePE9u/ykBroL1LZq4mWwbU=";
            };
            deleteVendor = true;
            vendorHash = "sha256-Dk5gG0EQ+2uoTnHfoZ8j+ctlB65vB9eA5JEe1rH+4mM=";

            preConfigure = ''
              export GOCACHE=$TMPDIR/go-cache
              export GOPATH="$TMPDIR/go"
              export GOPROXY=off
            '';

            preBuild = ''
              HOME=$TMPDIR
            '';
            postPatch = ''
              go mod vendor
            '';
          };
        }
      );
    };
}
