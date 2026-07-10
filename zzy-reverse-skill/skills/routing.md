# Reverse Engineering Skill Routing Matrix

Route tasks to the most appropriate skill module by target type, user intent, and toolchain.

## CRITICAL: Routing Execution Protocol

1. **MUST** complete routing BEFORE executing. Do NOT "do first, route later".
2. **MUST** match ALL three dimensions (target type + user intent + toolchain) before entering a skill.
3. If route not matched → propose new skill, do NOT force-fit.
4. Cross-module tasks → combine skills per "Path Crossing" section.
5. After routing, read the target skill's SKILL.md BEFORE taking action.

## By Target Type

| Target Type | Recommended Entry | Alternative |
|-------------|------------------|-------------|
| APK / Android app | `apk-reverse/` — jadx decompile + apktool unpack | If core is in .so → `ida-reverse/` or `radare2/` |
| Binary exe/dll/so/elf | `ida-reverse/` — IDA Pro decompile | `radare2/` — CLI analysis, or `reverse-engineering/tools.md` — GDB/Unicorn |
| JavaScript / Web frontend | `js-reverse/` — 5-stage workflow | anything-analyzer MCP browser tools, or jshookmcp CDP/Hook |
| HTTP capture / browser sampling / request replay | anything-analyzer MCP (23816) | `js-reverse/`, jshookmcp, or `competition-web-runtime/` |
| Firmware / IoT | `reverse-engineering/platforms.md` — binwalk/ARM/MIPS | `reverse-engineering/tools.md` — Ghidra headless |
| WASM / Python bytecode / .NET | `reverse-engineering/languages.md` | Check specific language section |
| macOS / iOS | `reverse-engineering/platforms.md` — Mach-O/ObjC/Swift | `mobile-reverse/` for iOS-specific |
| Game (Unity) | `reverse-engineering/` — engine reverse, anti-cheat, IL2CPP/Mono (see seed-014) | `ida-reverse/` deep analysis |
| Memory dump / PCAP | `reverse-engineering/platforms.md` | `reverse-engineering/patterns*.md` |
| Malware / virus sample | `reverse-engineering/` — YARA/sandbox/behavior analysis | `ida-reverse/` deep analysis |
| OLLVM-obfuscated binary (控制流平坦化/虚假控制流/MBA) | `reverse-engineering/references/ollvm-deobfuscation.md` — 完整脱密工作流 | obpo-plugin / d810-ng (IDA) / ollvm-unflattener (Miasm) / ollvm-breaker (Binary Ninja) / angr / deollvm (ARM64)
| Cryptography / encryption algorithms | `reverse-engineering/patterns*.md` — crypto patterns | `js-reverse/` (if frontend crypto) |
| Protocol reverse / custom protocol | `reverse-engineering/platforms.md` — network protocols | `js-reverse/` (if WebSocket/HTTP) |
| Go / Rust binary | `reverse-engineering/languages-compiled.md` + `go-reverse.md` | `ida-reverse/` or `radare2/` |
| LLM / AI application | `llm-security/` — OWASP LLM Top 10 + ASI Top 10 | Prompt injection, Agent security |
| API / REST / GraphQL | `api-security/` — BOLA/BFLA/JWT/OAuth | `pentest-tools/` for scanning |
| Supply chain / SBOM / CI-CD | `supply-chain-security/` — Trivy/Syft/Gitleaks | — |
| iOS app (IPA) | `mobile-reverse/` — class-dump/Hopper/Frida iOS | `reverse-engineering/platforms.md` |
| **CTF competition (full stack)** | `../CTF-Sandbox-Orchestrator/ctf-sandbox-orchestrator/SKILL.md` — master entry | Route to 40+ sub-skills by evidence |
| Web runtime / API | `../CTF-Sandbox-Orchestrator/competition-web-runtime/SKILL.md` | — |
| Cloud / Container / K8s | `../CTF-Sandbox-Orchestrator/competition-agent-cloud/SKILL.md` | — |
| Windows / AD / Identity | `../CTF-Sandbox-Orchestrator/competition-identity-windows/SKILL.md` | — |
| Forensics / PCAP / Steganography | `../CTF-Sandbox-Orchestrator/competition-forensic-timeline/SKILL.md` | — |
| Prompt injection / Agent | `../CTF-Sandbox-Orchestrator/competition-prompt-injection/SKILL.md` | — |
| Mobile (Android/iOS) | `../CTF-Sandbox-Orchestrator/competition-android-hooking/SKILL.md` | — |
| Firmware / Malware sample | `../CTF-Sandbox-Orchestrator/competition-firmware-layout/SKILL.md` | — |

## By User Intent

| User Says | Route To |
|-----------|----------|
| "decompile / IDA analyze" | `ida-reverse/SKILL.md` — IDA MCP workflow |
| "recover source / disassemble" | `reverse-engineering/SKILL.md` + `ida-reverse/` |
| "Frida hook / dynamic inject" | `reverse-engineering/tools-dynamic.md` — Frida section |
| "radare2 / r2 analyze" | `radare2/SKILL.md` — CLI workflow |
| "find frontend signature / encrypted params" | `js-reverse/SKILL.md` — Observe→Capture→Rebuild |
| "jshookmcp / JS hook / CDP debug" | `js-reverse/SKILL.md` — same JS/Web chain |
| "APK unpack / repack / modify smali" | `apk-reverse/SKILL.md` — decode→rebuild-sign-install |
| "bypass anti-debug / anti-detection" | `reverse-engineering/anti-analysis.md` |
| "OLLVM deobfuscate / 控制流平坦化去除 / deflat / 脱混淆" | `reverse-engineering/references/ollvm-deobfuscation.md` — 完整工作流 |
| "obpo / obpo-plugin / d810-ng / d810" | `reverse-engineering/references/ollvm-deobfuscation.md` — 现代反混淆工具 |
| "Hikari / Polaris / Pluto / O-MVLL / Arkari / goron 混淆" | `reverse-engineering/references/ollvm-deobfuscation.md` — 现代 OLLVM 变种处理 |
| "Tigress / Hodur / Approov 混淆" | `reverse-engineering/references/ollvm-deobfuscation.md` — d810-ng 专用 unflattener |
| "Trap Angr / angr 路径爆炸" | `reverse-engineering/references/ollvm-deobfuscation.md` — Pluto/Polaris 陷阱处理 |
| "BR 混淆 / 间接分支混淆去除" | `reverse-engineering/references/ollvm-deobfuscation.md` — DeObfBR + 数据段只读 |
| "what obfuscation / VM is this" | `reverse-engineering/patterns*.md` — match by pattern |
| "Go/Rust/Swift reverse" | `reverse-engineering/languages-compiled.md` + `go-reverse.md` |
| "kernel driver / Rootkit / LKM" | `reverse-engineering/kernel-driver-reverse.md` |
| "Python bytecode / pyc" | `reverse-engineering/languages.md` — Python section |
| "symbol execution / angr" | `reverse-engineering/tools-dynamic.md` — angr section |
| "patch environment / Node reproduce" | `js-reverse/references/env-patching.md` |
| "CTF challenge / competition reverse" | `reverse-engineering/patterns-ctf*.md` |
| "write report / documentation" | `docs-generator/` — technical documentation |
| "write writeup" | `docs-generator/` — CTF writeup template |
| "open webpage / browser automation / fill form" | `browser-automation/SKILL.md` — Playwright |
| "crawl page / screenshot / auto login" | `browser-automation/SKILL.md` |
| "desktop automation / Windows automation" | `browser-automation/SKILL.md` — OpenReverse |
| "game reverse / anti-cheat / hack analysis" | `reverse-engineering/SKILL.md` — game reverse (IL2CPP/Unity/Cheat Engine) |
| "Unity / IL2CPP / Mono" | `reverse-engineering/SKILL.md` — Unity + `seed-014_unity-il2cpp-reverse.md` |
| "Cheat Engine / memory scan" | `reverse-engineering/SKILL.md` — Cheat Engine memory analysis |
| "symbol migration / cross-version compare" | `binary-diff/SKILL.md` — LLM batch migration |
| "missing PDB / old version symbols" | `binary-diff/SKILL.md` — cross-version symbol migration |
| "bindiff / function offset migration" | `binary-diff/SKILL.md` — binary diff |
| "port scan / Nmap" | `pentest-tools/SKILL.md` — information gathering |
| "vulnerability scan / Nuclei" | `pentest-tools/SKILL.md` — vulnerability detection |
| "SQL injection / SQLMap" | `pentest-tools/SKILL.md` — web pentest |
| "directory brute force / FFUF / Gobuster" | `pentest-tools/SKILL.md` — web pentest |
| "password cracking / Hashcat" | `pentest-tools/SKILL.md` — password cracking |
| "penetration testing / active scan" | `pentest-tools/SKILL.md` — pentest toolchain |
| "SRC hunting / Bug Bounty" | `pentest-tools/src-hunter/SKILL.md` — 19 playbooks + H1 cases |
| "WAF bypass" | `pentest-tools/src-hunter/references/payloader/` — 263 bypass steps |
| "draw diagram / flowchart / architecture" | `diagram-generator/SKILL.md` |
| "attack path diagram / sequence diagram" | `diagram-generator/SKILL.md` — Mermaid/Graphviz/PlantUML |
| "malware / virus analysis / sample analysis" | `reverse-engineering/SKILL.md` + YARA/sandbox |
| "firmware / IoT / binwalk / ARM" | `reverse-engineering/platforms-hardware.md` |
| "cryptography / AES / RSA" | `reverse-engineering/patterns*.md` — crypto pattern recognition |
| "protocol reverse / Protobuf / custom protocol" | `reverse-engineering/platforms.md` |
| "cloud security / container escape / K8s" | `../CTF-Sandbox-Orchestrator/competition-agent-cloud/SKILL.md` |
| "Prompt injection / AI security" | `llm-security/SKILL.md` — OWASP LLM + ASI Top 10 |
| "internal network / lateral movement" | `pentest-tools/SKILL.md` + `references/network-attack-defense.md` |
| "privilege escalation" | `pentest-tools/references/network-attack-defense.md` — escalation section |
| "Mimikatz / credential extraction / PtH" | `pentest-tools/references/network-attack-defense.md` |
| "Kerberos / domain pentest / AD" | `pentest-tools/references/network-attack-defense.md` |
| "C2 / persistence / remote control" | `pentest-tools/references/network-attack-defense.md` |
| "blue team / detection / defense / IR" | `pentest-tools/references/network-attack-defense.md` |
| "APK security testing / mobile security" | `apk-reverse/references/apk-security-checklist.md` — OWASP MASTG |
| "SSTI / template injection" | `pentest-tools/SKILL.md` — SSTImap |
| "XSS scan / cross-site scripting" | `pentest-tools/SKILL.md` — XSStrike |
| "WordPress pentest / WP enumeration" | `pentest-tools/SKILL.md` — WPProbe |
| "C2 framework / adversary simulation" | `pentest-tools/SKILL.md` — AdaptixC2 |
| "WiFi attack / wireless pentest" | `pentest-tools/SKILL.md` — Fluxion + aircrack-ng |
| "NTLM relay / auth coercion" | `pentest-tools/SKILL.md` — Coercer |
| "NetExec / CrackMapExec / nxc" | `pentest-tools/SKILL.md` — network service enumeration |
| "AI auto pentest / MCP security" | `pentest-tools/SKILL.md` — HexStrike AI / MetasploitMCP |
| "Swarm / swarm pentest / autonomous scan" | `pentest-tools/SKILL.md` — Pentest Swarm AI |
| "red team / HW / attack exercise" | `attack-chain/SKILL.md` — full attack chain orchestration |
| "initial breach / boundary breach" | `attack-chain/SKILL.md` — boundary breach phase |
| "close-range pentest / BadUSB / WiFi phishing" | `attack-chain/SKILL.md` — close-range section |
| "EDR bypass / evasion / AV bypass" | `attack-chain/SKILL.md` — EDR/AV evasion section |
| "phishing / social engineering" | `attack-chain/SKILL.md` — phishing section |
| "supply chain attack" | `attack-chain/SKILL.md` — supply chain section |
| "trace cleanup / anti-forensics" | `attack-chain/SKILL.md` — cleanup section |
| "full pentest / end-to-end" | `attack-chain/SKILL.md` — full chain planning |
| "from external to domain controller" | `attack-chain/SKILL.md` — cross-phase path orchestration |
| "attack surface assessment / path planning" | `attack-chain/SKILL.md` — path planning decision tree |
| "got shell, what next / post-exploitation" | `attack-chain/SKILL.md` — plan from current foothold |
| "BurpSuite / Burp proxy / intercept" | `pentest-tools/SKILL.md` + `references/burpsuite-mcp-guide.md` |
| "Burp MCP / proxy history analysis" | `pentest-tools/references/burpsuite-mcp-guide.md` — 63 tools |
| "Intruder brute force / Repeater replay" | `pentest-tools/references/burpsuite-mcp-guide.md` |
| "Collaborator / OOB testing" | `pentest-tools/references/burpsuite-mcp-guide.md` |
| "API security / GraphQL / JWT attack" | `api-security/SKILL.md` — REST/GraphQL/JWT/OAuth |
| "supply chain security / SBOM / SCA" | `supply-chain-security/SKILL.md` — Trivy/Syft/Gitleaks |
| "iOS reverse / IPA / Mach-O" | `mobile-reverse/SKILL.md` — class-dump/Hopper/Frida iOS |
| "Objection / SSL Pinning bypass" | `mobile-reverse/SKILL.md` — dynamic instrumentation |
| "YARA / malware detection rules" | `malware-analysis/SKILL.md` — YARA/Sigma/IOC |
| "N-day / patch diff / CVE reproduction" | `binary-diff/SKILL.md` — ghidriff/Diaphora/DeepDiff |
| "MBA simplification / mixed boolean-arithmetic / 表达式化简" | `reverse-engineering/references/ollvm-deobfuscation.md` — SiMBA/D-810 |
| "opaque predicate / 不透明谓词去除" | `reverse-engineering/references/ollvm-deobfuscation.md` — 符号执行去除 |
| "Hikari deobfuscate / 字符串加密恢复" | `reverse-engineering/references/ollvm-deobfuscation.md` — Hikari 变种处理 |
| "pwn / stack overflow / ROP / ret2libc" | `reverse-engineering/patterns-ctf*.md` + pwntools |
| "Agent not working / AI lazy / skip steps" | `llm-security/references/agent-obedience-engineering.md` |
| "MSF stuck / orphan process / MSF protocol" | `pentest-tools/references/msf-protocol.md` |
| "anonymize / placeholder / writeup desensitize" | `field-journal/anonymization.md` |
| "Hydra / online brute force" | `pentest-tools/SKILL.md` — online password attack |
| "Metasploit / msfconsole / exploit" | `pentest-tools/SKILL.md` — exploitation framework |
| "Wireshark / packet analysis / PCAP" | `pentest-tools/SKILL.md` + `reverse-engineering/platforms.md` |
| "BurpSuite / web proxy / intercept" | `pentest-tools/SKILL.md` — web proxy |
| "ProxyCat / proxy pool / IP rotation" | `pentest-tools/SKILL.md` — proxy management |

## By Toolchain

| Tool | Related Module |
|------|---------------|
| IDA Pro (idapro_*) | `ida-reverse/` — MCP HTTP server + 72 tools |
| radare2 (r2/rabin2/rasm2) | `radare2/` — CLI + recon.ps1 |
| jadx / apktool | `apk-reverse/` — decode.ps1 / manifest-summary.ps1 |
| Frida | `reverse-engineering/tools-dynamic.md` |
| GDB / GEF / pwndbg / rr | `reverse-engineering/tools.md` |
| Ghidra (headless) | `reverse-engineering/tools.md` + Ghidra MCP |
| angr / Qiling / Unicorn | `reverse-engineering/tools-dynamic.md` |
| D-810 / d810-ng | `reverse-engineering/references/ollvm-deobfuscation.md` — IDA Pro 反混淆插件，OLLVM/Tigress/Hodur/Approov + Z3 SMT |
| obpo-plugin | `reverse-engineering/references/ollvm-deobfuscation.md` — Hex-Rays microcode 云插件，效果最强 |
| ollvm-unflattener (Miasm) / ollvm-breaker (Binary Ninja) | `reverse-engineering/references/ollvm-deobfuscation.md` — 无 IDA 场景 / BN 场景 |
| DeObfBR | `reverse-engineering/references/ollvm-deobfuscation.md` — BR 间接分支混淆专项 |
| deflat (QuarksLab) / angr symbol | `reverse-engineering/references/ollvm-deobfuscation.md` — 控制流平坦化去除 |
| GOOMBA (Ghidra) | `reverse-engineering/references/ollvm-deobfuscation.md` — Ghidra P-Code 反混淆 |
| BinDiff / Diaphora | `reverse-engineering/tools-advanced.md` |
| anything-analyzer MCP | Port 23816 MCP server (browser + HTTP capture + AI analysis) |
| jshookmcp | `js-reverse/` enhancement MCP for browser/CDP/Hook/Network/SourceMap/AST |
| agent-browser / Playwright | `browser-automation/` — browser automation |
| OpenReverse (UIA/CUA) | `browser-automation/` — Windows desktop automation |
| Cheat Engine / x64dbg / ReClass | `reverse-engineering/` — game memory analysis (seed-014) |
| IL2CPP Dumper / dnSpy | `reverse-engineering/` — Unity/Mono game reverse (seed-014) |
| LLM symbol migration / BinDiff alternative | `binary-diff/` — cross-version batch migration |
| Nmap / Masscan | `pentest-tools/` — port scan, service identification |
| Nuclei / ZAP / Nikto | `pentest-tools/` — vulnerability scanning |
| SQLMap / FFUF / Gobuster | `pentest-tools/` — web pentest (injection/brute force) |
| SSTImap | `pentest-tools/` — SSTI auto-detection |
| XSStrike | `pentest-tools/` — advanced XSS scanning |
| Hashcat / John / Hydra | `pentest-tools/` — password cracking |
| Metasploit / Impacket | `pentest-tools/` — exploitation framework |
| BurpSuite | `pentest-tools/` — web proxy, interception, vulnerability scanning |
| BurpSuite MCP | `pentest-tools/` — 63-tool AI full control, see `references/burpsuite-mcp-guide.md` |
| ProxyCat | `pentest-tools/` — proxy pool management & IP rotation |
| Cobalt Strike / Sliver / Havoc | `attack-chain/` — C2 framework |
| pentestMCP (Docker) | `pentest-tools/` — 20+ tools one-click MCP |
| Mermaid / Graphviz / PlantUML | `diagram-generator/` — diagram generation |
| garak / PyRIT / promptfoo | `llm-security/` — LLM red team testing |
| Trivy / Syft / Gitleaks / OSV-Scanner | `supply-chain-security/` — supply chain scanning |
| Objection / Frida iOS / class-dump | `mobile-reverse/` — iOS dynamic analysis |

Check `tool-index.md` for actual tool availability, paths, and versions. NEVER guess paths.

---

## Route Not Matched — Handling

If the current task doesn't match any table above, **do NOT force-fit into existing skill**:

1. Check if it's an edge case of an existing skill (can extend coverage)
2. If truly new type, proactively propose new skill to user:
   - Suggested skill name and coverage
   - Required toolchain
   - Relationship to existing skills
3. User confirms → execute per `CONTRIBUTING.md`
4. After creation, update this routing matrix

**AI does NOT need to wait for user to discover the gap. Route failure IS the signal to propose a new skill.**

## Path Crossing (Cross-Module Scenarios)

Some tasks span multiple modules. Common crossings:

```
APK Reverse Path:
  apk-reverse/decode.ps1 → Java layer analysis
  ↓ If core is in .so
  ida-reverse/ or radare2/ → .so analysis
  ↓ If dynamic verification needed
  apk-reverse/frida-run.ps1 → Frida Hook

Frontend JS Reverse Path:
  js-reverse/Observe → locate target request
  ↓ Need stronger browser/CDP/Hook/Network capability
  jshookmcp → runtime sampling, breakpoints, interception, SourceMap/AST
  ↓ After confirming entry function
  js-reverse/Rebuild → Node local reproduction
  ↓ Need environment patching
  js-reverse/references/env-patching.md

Binary Reverse Path:
  radare2/recon.ps1 → quick reconnaissance
  ↓ Deep analysis
  ida-reverse/ → IDA decompile
  ↓ Dynamic verification
  reverse-engineering/tools-dynamic.md → Frida/GDB

CTF Competition Path (via CTF-Sandbox-Orchestrator):
  ctf-sandbox-orchestrator/SKILL.md → build sandbox model
  ↓ Route by dominant evidence
  competition-web-runtime/ or competition-reverse-pwn/ or competition-identity-windows/
  ↓ Blocked → return to master
  ctf-sandbox-orchestrator → re-route

Web Pentest + BurpSuite MCP Path:
  browser-automation/ → auto-browse target with Burp proxy
  ↓ Traffic captured
  burpsuite MCP proxy_history → AI analyzes all requests
  ↓ Suspicious endpoints found
  burpsuite MCP intruder_attack → automated enumeration
  ↓ Vulnerability confirmed
  docs-generator/ → generate pentest report
```
