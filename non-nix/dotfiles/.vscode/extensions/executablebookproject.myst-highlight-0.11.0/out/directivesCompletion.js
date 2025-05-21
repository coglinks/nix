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
Object.defineProperty(exports, "__esModule", { value: true });
exports.HoverProvider = exports.directiveCompletion = exports.makeDescription = exports.CompletionItemProvider = exports.getDirectiveData = void 0;
const vscode = __importStar(require("vscode"));
const yaml = __importStar(require("js-yaml"));
const dirDict = __importStar(require("./data/directives.json"));
const dirRegexp = new RegExp(".*[`:]{3,}\\{"); // TODO check not backslash escapes
const dirStartRegexp = new RegExp("\\{[a-zA-Z0-9\\-]+\\}");
function getDirectiveData(name) {
    const dict = dirDict;
    return dict[name];
}
exports.getDirectiveData = getDirectiveData;
class CompletionItemProvider {
    provideCompletionItems(document, position, _token) {
        const { line, character } = position;
        if (character < 3) {
            return [];
        }
        const textLine = document.lineAt(line);
        const startLine = textLine.text.slice(undefined, character);
        if (dirRegexp.test(startLine)) {
            const completions = [];
            const dict = dirDict;
            for (const name in dirDict) {
                try {
                    directiveCompletion(name, dict[name], completions);
                }
                catch (error) {
                    console.warn(`Could not create directive completion: ${name}: ${error}`);
                }
            }
            return completions;
        }
        return [];
    }
}
exports.CompletionItemProvider = CompletionItemProvider;
function makeDescription(data, addClass = false) {
    const opts = yaml.safeDump({
        "Required Args": data["required_arguments"],
        "Optional Args": data["optional_arguments"],
        "Has Content": data["has_content"],
        Options: data["options"]
    });
    let string = "";
    if (addClass) {
        string = "`" + `${data["klass"]}` + "`\n\n";
    }
    string = string + `${data["description"]}`;
    const mdown = new vscode.MarkdownString(string);
    mdown.appendCodeblock(opts, "yaml");
    return mdown;
}
exports.makeDescription = makeDescription;
function directiveCompletion(name, data, completions) {
    const completion = new vscode.CompletionItem(name, vscode.CompletionItemKind.Class);
    completion.detail = data["klass"];
    completion.documentation = makeDescription(data);
    // completion.insertText = new vscode.SnippetString()
    completions.push(completion);
}
exports.directiveCompletion = directiveCompletion;
class HoverProvider {
    provideHover(document, position, _token) {
        const range = document.getWordRangeAtPosition(position, dirStartRegexp);
        if (range === undefined) {
            return new Promise(resolve => resolve(new vscode.Hover(new vscode.MarkdownString(""))));
        }
        const textLine = document.lineAt(range.start);
        const startLine = textLine.text.slice(undefined, range.start.character);
        if (!(startLine.endsWith("```") || startLine.endsWith(":::"))) {
            return new Promise(resolve => resolve(new vscode.Hover(new vscode.MarkdownString(""))));
        }
        // TODO check for backslash escapes
        let text = document.getText(range);
        text = text.slice(1, -1);
        if (!(text in dirDict)) {
            return new Promise(resolve => resolve(new vscode.Hover(new vscode.MarkdownString(""))));
        }
        const data = getDirectiveData(text);
        const mkdown = makeDescription(data, true);
        const hover = new vscode.Hover(mkdown, range);
        return new Promise(resolve => resolve(hover));
    }
}
exports.HoverProvider = HoverProvider;
//# sourceMappingURL=directivesCompletion.js.map