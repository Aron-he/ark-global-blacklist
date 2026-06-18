# ARK Global Blacklist

这是一个由《方舟非官黑名单共享群》维护的 **集中式黑名单仓库**，供其他服务器订阅使用。

## 📌 使用方式

服务器只需拉取以下文件：

- 黑名单链接  
  https://ghproxy.net/https://raw.githubusercontent.com/Aron-he/ark-global-blacklist/main/custom/blacklist.txt

- 官方列表合并版本（推荐）  
  https://ghproxy.net/https://raw.githubusercontent.com/Aron-he/ark-global-blacklist/main/build/blacklist.txt

- 剔除白名单后的官方列表合并版本  
  https://ghproxy.net/https://raw.githubusercontent.com/Aron-he/ark-global-blacklist/main/build/blacklist.without-whitelist.txt
  
## 📜 规则说明

- 本名单仅作为**参考**
- 本名单仅收录经过鉴定、证据清晰的作案分子，包括使用外挂、利用bug刷物资、恶意拖人下水等
- 不收录复杂的资源纠纷或私人恩怨等
- 所有记录均有更新日志可查（CHANGELOG.md）

## 🔒 维护说明

- 仅仓库维护者有写权限
- 所有更新都会记录时间与原因

## 白名单输出

- 将需要放行的 ID 写入 `custom/whitelist.txt`，每行一个 ID。
- `scripts/merge.sh` 会继续生成完整合并名单：`build/blacklist.txt`。
- 同时会生成剔除白名单后的合并名单：`build/blacklist.without-whitelist.txt`。
