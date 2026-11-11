<p align="center">
  <img src="assets/logo.png" alt="Wapliss logo" width="120" />
</p>

<h1 align="center">Wapliss WhatsApp for ChatGPT</h1>

<p align="center">
  <strong>Connect your own WhatsApp to ChatGPT with the Wapliss MCP server.</strong><br />
  Read and summarize chats and groups, and send messages, files, locations and polls, always with your confirmation.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-25D366" alt="License: MIT" />
  <img src="https://img.shields.io/badge/MCP-2026--07--28%20%7C%202025--11--25-128C7E" alt="MCP" />
  <img src="https://img.shields.io/badge/ChatGPT-plugin-128C7E" alt="ChatGPT" />
  <img src="https://img.shields.io/badge/version-1.0.1-25D366" alt="Version" />
  <img src="https://img.shields.io/badge/OpenAI%20review-in%20review-f59e0b" alt="Status" />
</p>

<p align="center">
  <a href="https://wapliss.com/">Website</a> ·
  <a href="https://wapliss.com/integrations#chatgpt">ChatGPT guide</a> ·
  <a href="https://wapliss.com/integraciones#chatgpt">Guía en español</a> ·
  <a href="#example-prompts">Examples</a> ·
  <a href="#faq">FAQ</a> ·
  <a href="#wapliss-plugins">Other assistants</a>
</p>

---

## What is Wapliss?

[Wapliss](https://wapliss.com/), by [NetDigitalTech LLC](https://netdigitaltech.com/), is a WhatsApp gateway for AI assistants. You
link your WhatsApp number once with a QR code, authorize your assistant, and
the assistant can read your chats and groups and send WhatsApp messages for
you through a standard [Model Context Protocol](https://modelcontextprotocol.io/)
(MCP) server. A free plan is available, with no credit card required.

This repository is the official **ChatGPT package** of Wapliss
(ChatGPT plugin in the Agent Plugins format, with an MCP server and a skill). It only points ChatGPT to the hosted Wapliss MCP
server; it stores no account data, messages or credentials.

## Compatibility

| Surface | How | Status |
| --- | --- | --- |
| ChatGPT plugin directory | **Plugins → Wapliss WhatsApp → Connect** | In review by OpenAI (1.0.1) |
| ChatGPT web (any plan) | **Add custom MCP server** with `https://wapliss.com/mcp` and OAuth | Works today |
| ChatGPT desktop | Plugin installed from this package | Works |

## Quick start

1. Create a free account at [wapliss.com](https://wapliss.com/) and link your
   phone once at [wapliss.com/app/connect](https://wapliss.com/app/connect)
   (WhatsApp → Linked devices → Link a device → scan the QR code).
2. In ChatGPT open **Plugins**, search **Wapliss WhatsApp** and click
   **Connect**. Until the listing is published, add a custom MCP server:
   **Plugins → Add → Add custom MCP server**, URL `https://wapliss.com/mcp`,
   authentication **OAuth**.
3. Sign in to Wapliss and approve access.
4. Ask: *"Show me my latest WhatsApp messages"*.

## Example prompts

| Goal | Ask  |
| --- | --- |
| Catch up | "Show me my latest WhatsApp messages" |
| Summarize a group | "Summarize what was said today in my family group" |
| Read a chat | "Read my last 20 messages with Ana and tell me what she needs" |
| Group info | "Who are the admins of the work group?" |
| Send a message | "Send 'On my way, 10 minutes' to +1 555 010 2030" |
| Send a file | "Send this PDF to Laura: https://example.com/quote.pdf" |
| Share a location | "Send the office location to the project group" |
| Run a poll | "Create a poll in the team group: Friday or Monday?" |
| Check the account | "Check my Wapliss account and today's usage" |

Tips: name the chat or group as it appears in WhatsApp, or use the number with
country code. The assistant shows you the recipient and the text before
sending when anything is ambiguous.

## What it can do (16 tools)

| Area | Tools | What they do |
| --- | --- | --- |
| Chats and groups | `get_chats`, `get_chat_history`, `get_message` | List and search your conversations, read a chat or group in order, get one message |
| Latest activity | `get_last_incoming_messages`, `get_last_outgoing_messages` | What you received or sent recently, across all chats |
| Groups | `get_group` | Name, description, admins and participants |
| Send | `send_text_message`, `send_image`, `send_document`, `send_audio`, `send_video`, `send_location`, `send_contact`, `send_poll`, `forward_messages` | Text, files by public URL, locations, contact cards, polls and forwards |
| Account | `get_account_status` | Plan, linked number, daily usage and quota |

Every tool declares MCP annotations (`readOnlyHint`, `destructiveHint`,
`idempotentHint`, `openWorldHint`). Send tools are marked destructive, so the
assistant asks for confirmation. A successful send means the message was
**queued** (with a `queue_id`), not yet delivered.

## How it works

```text
ChatGPT --OAuth 2.1 (PKCE S256, dynamic client registration)--> https://wapliss.com/mcp
                                                                        |
                                                             Wapliss WhatsApp engine
                                                                        |
                                                                    WhatsApp
```

- Protected resource metadata: `https://wapliss.com/.well-known/oauth-protected-resource`
- Authorization server metadata: `https://wapliss.com/.well-known/oauth-authorization-server`
- Scopes: `wapliss:mcp`, `whatsapp:read`, `whatsapp:write`
- MCP protocol: 2026-07-28 (`server/discover`) with fallback to 2025-11-25 and earlier.

## Security and privacy

- **Your own account only.** The assistant can reach only the WhatsApp account
  linked to your Wapliss account, and only when you ask.
- **No credentials in the chat.** Never paste passwords, API keys, QR data or
  session data into a conversation; this package contains none either.
- **Confirmation before sending.** Ambiguous recipients or texts are confirmed
  first; bulk or unsolicited messaging is not allowed.
- **Revocable at any time** from the Wapliss dashboard.
- **Limits:** daily plan quota and 60 MCP calls per minute per user.
- [Privacy policy](https://wapliss.com/privacy-policy) ·
  [Terms of service](https://wapliss.com/terms-of-service)

## FAQ

**Is it free?** Yes, there is a free plan to start, with no credit card.

**Does it use the official WhatsApp Business Platform?** No. Wapliss links
your number as a WhatsApp linked device, like WhatsApp Web, so it works with
your personal or business number without a Meta Business account. Use it for
your own conversations and follow WhatsApp's terms.

**Can the assistant send messages on its own?** No. It only acts when you ask,
confirms ambiguous sends and refuses bulk or unsolicited messages.

**Where are my messages stored?** In your private Wapliss account, so the
assistant can read them when you ask. What the assistant reads is processed by
its AI provider. See the [privacy policy](https://wapliss.com/privacy-policy).

**Can I use several assistants at once?** Yes. Each one is authorized
separately and can be revoked separately.

**Why can't I see Wapliss in the ChatGPT directory yet?** It is in review by
OpenAI. Use the custom MCP server option in the meantime; it works on every
plan, including Free.

## Troubleshooting

| Message from Wapliss | What it means | What to do |
| --- | --- | --- |
| `account_awaiting_qr` / `instance_not_connected` | No phone is linked to this Wapliss account | Link it at [wapliss.com/app/connect](https://wapliss.com/app/connect) |
| `account_disconnected` | WhatsApp closed the linked session | Scan the QR code again |
| `quota_exceeded` | Daily message quota reached | Wait for the reset or upgrade the plan |
| Rate limit (`-32300` / HTTP 429) | More than 60 calls in a minute | Wait the seconds indicated |
| `chat_not_found` | No chat matches the name or number | Search with another name or the full number with country code |

## Package layout

```text
plugin.json                       Agent Plugins manifest (extensions.com.openai: listing, review test cases)
mcp.json                          Remote MCP server (Streamable HTTP, OAuth)
skills/wapliss-whatsapp/SKILL.md  Usage rules for the assistant
assets/logo.png                   Logo and composer icon (640 × 640)
scripts/build-zip.sh              Builds the ZIP uploaded to OpenAI
```

## Build and submit (maintainers)

```bash
./scripts/build-zip.sh        # creates dist/wapliss-whatsapp-<version>.zip
```

Upload the ZIP at [platform.openai.com/plugins](https://platform.openai.com/plugins).
Reviewer credentials and the demo video are entered in the dashboard, never in
this repository. Tool changes on the server need no new ZIP (OpenAI rescans the
MCP server); listing, asset or skill changes need a version bump in
`plugin.json` and `SKILL.md`.

## Wapliss plugins

Wapliss works the same way in every assistant: one account, one linked phone,
the same 16 tools.

| Assistant | Where it works | Format | Get it |
| --- | --- | --- | --- |
| Claude | Claude.ai, Claude Desktop, Claude Code | Custom connector / Claude plugin | [github.com/proteuscrypto/wapliss-whatsapp-for-claude](https://github.com/proteuscrypto/wapliss-whatsapp-for-claude) |
| **ChatGPT** | ChatGPT web and desktop | ChatGPT plugin (Agent Plugins) / custom MCP connector | this repository |
| Gemini | Gemini app, Gemini CLI, Antigravity | Connected app, Gemini CLI extension, Antigravity plugin | [github.com/proteuscrypto/wapliss-for-gemini](https://github.com/proteuscrypto/wapliss-for-gemini) |
| DeepSeek | DeepSeek Harness (dsh) | dsh bundle | [github.com/proteuscrypto/wapliss-for-deepseek](https://github.com/proteuscrypto/wapliss-for-deepseek) |
| GitHub Copilot | VS Code, Copilot CLI, Copilot app | Agent Plugins 1.0 | [github.com/proteuscrypto/wapliss-for-copilot](https://github.com/proteuscrypto/wapliss-for-copilot) |
| Grok | Grok Build, grok.com connectors, xAI API | Grok Build plugin / custom MCP connector | [github.com/proteuscrypto/wapliss-for-grok](https://github.com/proteuscrypto/wapliss-for-grok) |
| Any MCP client | Clients with remote MCP (Streamable HTTP) | OAuth 2.1, or a personal API key | [wapliss.com/integrations#mcp](https://wapliss.com/integrations#mcp) |

## Credits and support

- **Created and maintained by [NetDigitalTech LLC](https://netdigitaltech.com/)**
  ([GitHub](https://github.com/netdigitaltech)), the company that created and owns
  [Wapliss](https://wapliss.com/). NetDigitalTech builds web, mobile and AI
  applications. Albuquerque, New Mexico, USA · commerce@netdigitaltech.com
- Support: [open an issue](https://github.com/proteuscrypto/wapliss-for-chatgpt/issues) in this repository.
- Integration guides: [English](https://wapliss.com/integrations#chatgpt) ·
  [Español](https://wapliss.com/integraciones#chatgpt)

## Español

**Wapliss WhatsApp para ChatGPT**: conecta tu propio WhatsApp a
ChatGPT con el servidor MCP de Wapliss. Lee y resume chats y grupos y
envía mensajes, archivos, ubicaciones y encuestas, siempre con tu confirmación.

Cómo empezar: crea tu cuenta gratis en wapliss.com, vincula tu teléfono en
[wapliss.com/app/connect](https://wapliss.com/app/connect) y en ChatGPT abre
**Complementos → Wapliss WhatsApp → Conectar**. Mientras el directorio está
en revisión, usa **Agregar servidor MCP personalizado** con
`https://wapliss.com/mcp` y OAuth (funciona en el plan gratuito).

Ejemplos: *"Muéstrame mis últimos mensajes de WhatsApp"*, *"Resume lo que se
habló hoy en el grupo de la familia"*, *"Envía 'Llego en 10 minutos' a
+54 9 11 5555 0100"*. Creado y mantenido por **[NetDigitalTech LLC](https://netdigitaltech.com/)**,
la empresa creadora y dueña de [Wapliss](https://wapliss.com/). Guía completa:
[wapliss.com/integraciones#chatgpt](https://wapliss.com/integraciones#chatgpt).

## Trademarks and license

ChatGPT and OpenAI are trademarks of OpenAI. WhatsApp is a trademark of Meta Platforms, Inc. Wapliss is
an independent service and is not affiliated with, sponsored or endorsed by
Meta, WhatsApp or OpenAI.

Released under the [MIT License](LICENSE). © 2026 NetDigitalTech LLC, creator and owner of Wapliss.
