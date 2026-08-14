import { readFile, writeFile } from "node:fs/promises"

// TODO add path to file as arg
const schema = await readFile("/home/shd/projects/tv-show-impressions/backend/db/schema.sql", "utf8")

const typeMap: Record<string, string> = {
  INTEGER: "number",
  INT: "number",
  REAL: "number",
  FLOAT: "number",
  DOUBLE: "number",
  TEXT: "string",
  VARCHAR: "string",
  CHAR: "string",
  BOOLEAN: "boolean",
  BLOB: "Uint8Array",
  DATE: "string",
  DATETIME: "string",
}

function toPascalCase(name: string) {
  return name
    .split("_")
    .map(x => x.charAt(0).toUpperCase() + x.slice(1))
    .join("")
}

const output: string[] = [
  "// AUTO-GENERATED. DO NOT EDIT.",
  "",
]

const tables = schema.matchAll(
  /CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?["'`]?(\w+)["'`]?\s*\(([\s\S]*?)\);/gi
)

for (const match of tables) {
  const [, tableName, body] = match

  const columns = body
    .split(",")
    .map(x => x.trim())
    .filter(x =>
      x &&
      !/^(PRIMARY|FOREIGN|UNIQUE|CHECK|CONSTRAINT)\b/i.test(x)
    )

  output.push(`export interface ${toPascalCase(tableName)} {`)

  for (const column of columns) {
    const match = column.match(
      /^["'`]?(\w+)["'`]?\s+(\w+)(?:\(\d+(?:,\s*\d+)?\))?/i
    )

    if (!match) continue

    const [, name, sqlType] = match

    const tsType =
      typeMap[sqlType.toUpperCase()] ?? "unknown"

    const nullable = !/\bNOT\s+NULL\b/i.test(column)

    output.push(
      `  ${name}: ${tsType}${nullable ? " | null" : ""}`
    )
  }

  output.push("}", "")
}

await writeFile("types.ts", output.join("\n"))

console.log("Generated src/types.ts")
