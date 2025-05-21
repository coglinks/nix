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
exports.readSnippets = exports.readGrammar = void 0;
const fs = __importStar(require("fs"));
const path = __importStar(require("path"));
const yaml = __importStar(require("js-yaml"));
const jinja = __importStar(require("nunjucks"));
const plist = __importStar(require("plist"));
function readGrammar(asPlist = false) {
    const templateYaml = fs.readFileSync(path.join(__dirname, "../template/myst.tmLanguage.j2.yaml"), "utf8");
    const languageYaml = fs.readFileSync(path.join(__dirname, "../template/languages.yaml"), "utf8");
    const directiveYaml = fs.readFileSync(path.join(__dirname, "../template/directives.yaml"), "utf8");
    // read variables
    const languages = yaml.safeLoad(languageYaml);
    const directives = yaml.safeLoad(directiveYaml);
    // inject variables
    const inputYaml = jinja
        .renderString(templateYaml, {
        admonition_classes: directives["admonition_classes"],
        code_classes: directives["code_classes"],
        languages
    })
        .toString();
    const grammar = yaml.safeLoad(inputYaml);
    if (asPlist) {
        return plist.build(grammar);
    }
    return grammar;
}
exports.readGrammar = readGrammar;
function getDefault(obj, name, defaultValue = null) {
    const value = obj[name];
    if (value === undefined) {
        // eslint-disable-next-line @typescript-eslint/no-unsafe-return
        return defaultValue;
    }
    // eslint-disable-next-line @typescript-eslint/no-unsafe-return
    return value;
}
function readSnippets(asJson = false) {
    const snippetsYaml = fs.readFileSync(path.join(__dirname, "../snippets/dir.template.yaml"), "utf8");
    const snippets = yaml.safeLoad(snippetsYaml);
    const finalData = {};
    for (const name in snippets) {
        const data = snippets[name];
        if (data === null || data === undefined) {
            finalData[`directive-${name}`] = {
                description: `a ${name} directive`,
                prefix: [`directive-${name}`],
                body: [`\`\`\${1:\`}{${name}}`, "${0:content}", "``${1:`}", ""]
            };
        }
        else {
            let dname = getDefault(data, "name", null);
            if (dname === null) {
                dname = name;
            }
            const args = getDefault(data, "arguments", null);
            const options = getDefault(data, "options", null);
            let bodyStrings;
            if (args !== null) {
                bodyStrings = [`\`\`\${1:\`}{${dname}} \${2:${args}}`];
            }
            else {
                bodyStrings = [`\`\`\${1:\`}{${dname}}`];
            }
            if (options !== null) {
                let lines = yaml.safeDump(options).split(/\r?\n/);
                const unnested = (line) => {
                    return !line.startsWith(" ");
                };
                if (lines.every(unnested)) {
                    lines = lines.filter(l => l !== "");
                    bodyStrings.push(...lines.map(l => `:${l}`));
                    bodyStrings.push("");
                }
                else {
                    bodyStrings.push("---");
                    bodyStrings.push(...lines);
                    bodyStrings.push("---");
                }
            }
            if (getDefault(data, "content", true) !== false) {
                let content = getDefault(data, "content", null);
                if (content === null) {
                    content = "content";
                }
                bodyStrings.push(`\${0:${content}}`);
            }
            bodyStrings.push("``${1:`}");
            bodyStrings.push("");
            finalData[`directive-${name}`] = {
                description: `a ${name} directive`,
                prefix: [`directive-${name}`],
                body: bodyStrings
            };
        }
    }
    if (asJson) {
        return JSON.stringify(finalData, null, 2);
    }
    return finalData;
}
exports.readSnippets = readSnippets;
//# sourceMappingURL=readTemplates.js.map