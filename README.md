# zhuge-cto-protocol

> 诸葛↔Dyson 技术任务协作协议 — 一键安装，多点复用

## 安装

```bash
npx github:wangjohnson/zhuge-cto-protocol
```

或直接 curl：

```bash
curl -sSL https://raw.githubusercontent.com/wangjohnson/zhuge-cto-protocol/main/install.sh | bash
```

## 用法

在诸葛 session 里说：

```
加载 zhuge-dyson-task-protocol
```

之后所有技术类任务（部署/排查/配置/优化）自动按协议流转。

## 协议简述

```
用户 → 诸葛(意图识别+路由) → Dyson(CTO+委托+验货) → 诸葛(校验) → 用户
```

- 诸葛：flash 模型，只做意图+路由+校验，不碰技术
- Dyson：pro 模型，架构设计+委托子代理+独立验货
- 子代理：flash 模型，纯机械执行
- Dyson 是质量过滤器——子代理输出不传诸葛

## 目录结构

```
zhuge-cto-protocol/
├── package.json
├── install.sh
├── protocols/
│   └── zhuge-dyson-task-protocol/
│       └── SKILL.md
└── README.md
```
