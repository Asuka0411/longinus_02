# Longinus-02 🔴
>
> *Piercing through the complexity.*

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)

**Longinus-02** 是一个基于 Flutter 的个人开发脚手架与功能展示项目 (Showcase)。
致敬 **EVA Unit-02** 与 **Longinus Spear**，旨在打造一把开发利器。

📖 **[开发文档与规范](./docs/)** | 🗺️ **[项目路线图](./docs/ROADMAP.md)**

## 🏗 Project Structure

本项目采用 **Feature-First + Atomic Design** 混合架构：

```text
lib/
├── core/               # 核心基础层 (Utilities, Constants, Theme)
│   ├── constants/
│   ├── theme/
│   └── utils/
├── ui_kit/             # UI 组件库 (Atomic Design)
│   ├── atoms/          # 基础原子 (Text, Icon, Colors)
│   ├── molecules/      # 分子组件 (Buttons, Inputs)
│   └── organisms/      # 复杂组件 (Cards, Lists)
└── features/           # 业务功能模块
    ├── home/
    └── dashboard/
```

## 🚀 Getting Started

1. **Clone** the repository.
2. Run `flutter pub get`.
3. Run `flutter run`.

## 🛠 Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: (TBD)
- **Networking**: (TBD)

---
*Created by [Asuka0411](https://github.com/Asuka0411)*
