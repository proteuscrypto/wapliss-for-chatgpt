<p align="center">
  <img src="assets/logo.png" alt="Wapliss logo" width="120" />
</p>

# Wapliss WhatsApp for ChatGPT

Use your own WhatsApp from ChatGPT through [Wapliss](https://wapliss.com/).
This repository contains only the ChatGPT plugin package. It connects to the
hosted Wapliss MCP service with OAuth; it stores no account data or WhatsApp
credentials.

## Setup (users)

1. In ChatGPT, open **Plugins**, search for **Wapliss WhatsApp** and add it.
2. Click **Connect**, then sign in to (or create) your account at
   [wapliss.com](https://wapliss.com/) and approve access.
3. Link your phone once in the Wapliss panel at
   [wapliss.com/app/connect](https://wapliss.com/app/connect): WhatsApp >
   Linked devices > Link a device, then scan the QR code.
4. Ask ChatGPT, for example: "Show me my latest WhatsApp messages".

Never paste Wapliss API keys, WhatsApp credentials or session data into the
chat. If authorization expires, use **Connect** again.

## What it can do

| Area | Tools |
| --- | --- |
| Read chats and groups | `get_chats`, `get_chat_history`, `get_message` |
| Latest activity | `get_last_incoming_messages`, `get_last_outgoing_messages` |
| Groups | `get_group` (name, description, admins, participants) |
| Send | `send_text_message`, `send_image`, `send_document`, `send_audio`, `send_video`, `send_location`, `send_contact`, `send_poll`, `forward_messages` |
| Account | `get_account_status` (plan, usage, quota) |

Sends are queued asynchronously: a successful call means the message was
queued, not delivered. Bulk or unsolicited messaging is not allowed.

## How it works

```text
ChatGPT --OAuth 2.1 (PKCE S256, DCR)--> https://wapliss.com/mcp
                                              |
                                   Wapliss WhatsApp engine
                                              |
                                          WhatsApp
```

OAuth metadata:
`https://wapliss.com/.well-known/oauth-protected-resource` (resource
`https://wapliss.com/mcp`) and
`https://wapliss.com/.well-known/oauth-authorization-server`.
Scopes: `wapliss:mcp`, `whatsapp:read`, `whatsapp:write`.

## Package layout

```text
plugin.json                       Agent Plugins manifest (extensions.com.openai)
mcp.json                          Remote MCP server (streamable HTTP)
skills/wapliss-whatsapp/SKILL.md  Usage rules for the assistant
assets/logo.png                   Logo and composer icon (640x640)
scripts/build-zip.sh              Builds the ZIP uploaded to OpenAI
```

## Build and submit (maintainers)

```bash
./scripts/build-zip.sh        # creates dist/wapliss-whatsapp-<version>.zip
```

Upload the ZIP at [platform.openai.com/plugins](https://platform.openai.com/plugins)
(**Upload new or existing plugin**). Reviewer credentials and the demo video
URL are entered in the dashboard, never in this repository.

- Changes to tools on the server need no new ZIP: OpenAI rescans the MCP server.
- Changes to the listing, assets or skill: bump `version` in `plugin.json` and
  in `SKILL.md`, rebuild the ZIP and upload it to the existing plugin.

The Claude plugin lives in a separate repository:
[wapliss-whatsapp-for-claude](https://github.com/proteuscrypto/wapliss-whatsapp-for-claude).

## Support

Open an issue in this repository or write to proteuscrypto@gmail.com.

WhatsApp is a trademark of Meta Platforms, Inc. Wapliss is an independent
service and is not affiliated with or endorsed by Meta or OpenAI.
