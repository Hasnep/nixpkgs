

{
  lib,
  vscode-utils,
  ...
}:

vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    name = "jjk";
    publisher = "jjk";
    version = "0.8.1";
    hash = "sha256-2JUn6wkWgZKZzhitQy6v9R/rCNLrt7DBtt59707hp6c=";
  };
  meta = {
    changelog = "https://github.com/keanemind/jjk/releases";
    description = "Jujutsu (jj) VCS support for VS Code";
    downloadPage = "https://marketplace.visualstudio.com/items?itemName=jjk.jjk";
    homepage = "https://github.com/keanemind/jjk";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.hasnep ];
  };
}
