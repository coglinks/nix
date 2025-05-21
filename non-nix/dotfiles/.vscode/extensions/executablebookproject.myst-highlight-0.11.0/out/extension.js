"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deactivate = exports.activate = void 0;
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = __importStar(require("vscode"));
const directivesCompletion_1 = require("./directivesCompletion");
const markdown_it_front_matter_1 = __importDefault(require("markdown-it-front-matter"));
const markdown_it_footnote_1 = __importDefault(require("markdown-it-footnote"));
const markdown_it_docutils_1 = __importDefault(require("markdown-it-docutils"));
const markdown_it_dollarmath_1 = __importDefault(require("markdown-it-dollarmath"));
const markdown_it_amsmath_1 = __importDefault(require("markdown-it-amsmath"));
const markdown_it_deflist_1 = __importDefault(require("markdown-it-deflist"));
const markdown_it_task_lists_1 = __importDefault(require("markdown-it-task-lists"));
const katex_1 = require("katex");
const mdPlugins_1 = require("./mdPlugins");
const extensionId = "executablebookproject.myst-highlight";
// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
function activate(context) {
    // Use the console to output diagnostic information (console.log) and errors (console.error)
    // This line of code will only be executed once when your extension is activated
    console.log("Activated MyST-Markdown extension");
    // The command has been defined in the package.json file
    // Now provide the implementation of the command with registerCommand
    // The commandId parameter must match the command field in package.json
    const disposable = vscode.commands.registerCommand("myst.Activate", () => {
        // The code you place here will be executed every time your command is executed
        // Display a message box to the user
        void vscode.window.showInformationMessage("Activated MyST-Markdown!");
    });
    notifyNewReleases(context);
    context.subscriptions.push(disposable);
    const mdSelector = { scheme: "file", language: "markdown" };
    context.subscriptions.push(vscode.languages.registerCompletionItemProvider(mdSelector, new directivesCompletion_1.CompletionItemProvider(), "{"));
    context.subscriptions.push(vscode.languages.registerHoverProvider(mdSelector, new directivesCompletion_1.HoverProvider()));
    if (!vscode.workspace.getConfiguration("myst.preview").get("enable", true)) {
        return {};
    }
    return {
        extendMarkdownIt(md) {
            // note ideally here, we would want to specify the config as commonmark, rather than default
            const extensions = vscode.workspace
                .getConfiguration("myst.preview")
                .get("extensions", []);
            let newMd = md
                .enable("table")
                .use(markdown_it_front_matter_1.default, () => { })
                .use(mdPlugins_1.convertFrontMatter)
                .use(mdPlugins_1.mystBlockPlugin)
                .use(markdown_it_footnote_1.default)
                .disable("footnote_inline") // not yet implemented in myst-parser
                .use(markdown_it_docutils_1.default);
            if (extensions.includes("dollarmath")) {
                newMd = newMd.use(markdown_it_dollarmath_1.default, {
                    double_inline: true,
                    renderer: katex_1.renderToString,
                    optionsInline: { throwOnError: false, displayMode: false },
                    optionsBlock: { throwOnError: false, displayMode: true }
                });
            }
            if (extensions.includes("colon_fence")) {
                newMd = newMd.use(mdPlugins_1.colonFencePlugin);
            }
            if (extensions.includes("amsmath")) {
                newMd = newMd.use(markdown_it_amsmath_1.default, {
                    renderer: katex_1.renderToString,
                    options: { throwOnError: false, displayMode: true }
                });
            }
            if (extensions.includes("deflist")) {
                newMd = newMd.use(markdown_it_deflist_1.default);
            }
            if (extensions.includes("tasklist")) {
                newMd = newMd.use(markdown_it_task_lists_1.default);
            }
            // TODO substitutions
            return newMd;
        }
    };
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() { }
exports.deactivate = deactivate;
/** Notify users that if the extension has been updated to a new major release */
function notifyNewReleases(context) {
    var _a;
    const previousVersion = context.globalState.get("previousVersion");
    const currentVersion = (_a = vscode.extensions.getExtension(extensionId)) === null || _a === void 0 ? void 0 : _a.packageJSON.version;
    void context.globalState.update("previousVersion", currentVersion);
    if (typeof previousVersion !== "string") {
        console.log(`set previousVersion: ${currentVersion}`);
        return;
    }
    if (typeof currentVersion === "string" && currentVersion !== previousVersion) {
        if (isMajorUpdate(previousVersion, currentVersion)) {
            void vscode.window.showInformationMessage(`MyST-Markdown updated to v${currentVersion}. See the Changelog for what's new!`);
        }
    }
}
/** Check if major update to extension or, if major version is 0, check patch version */
function isMajorUpdate(previousVersion, currentVersion) {
    try {
        const previousVerArr = previousVersion.split(".").map(Number);
        const currentVerArr = currentVersion.split(".").map(Number);
        if (currentVerArr[0] === 0 && currentVerArr[1] > previousVerArr[1]) {
            return true;
        }
        if (currentVerArr[0] > previousVerArr[0]) {
            return true;
        }
    }
    catch (error) {
        console.warn(`Failed to read extension versions: ${error}`);
    }
    return false;
}
//# sourceMappingURL=extension.js.map