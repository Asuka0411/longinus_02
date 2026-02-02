# 开发标准与协作规范 (Standards)

本文档定义了 `Longinus 02` 项目的核心开发理念、编码规范及协作准则，适用于所有参与者（包括 AI 助手）。

## 1. 核心理念与原则 (Core Principles)

我们严格遵守以下核心原则，它们是所有决策的基石：

* **简洁至上 (KISS)**
  * 恪守 **KISS (Keep It Simple, Stupid)** 原则。
  * 崇尚简洁与可维护性，拒绝过度设计。
  * 避免不必要的防御性设计，代码应清晰表达意图。

* **深度分析 (First Principles)**
  * 立足于**第一性原理 (First Principles Thinking)** 剖析问题。
  * 在动手前必须彻底理解问题的本质。
  * 善用工具提升效率，但不盲目依赖。

* **事实为本 (Fact-Based)**
  * 以事实为最高准则。
  * 坦诚面对错误，及时修正，持续精进。

## 2. 开发工作流 (Workflow)

采用 **渐进式开发 (Progressive Development)** 模式：

1. **构思与分析 (Planning)**
    * 通过多轮对话明确需求。
    * 前期调研必须充分，厘清所有疑点。
    * **禁止**在未明确方案前编写代码。

2. **计划审核 (Review)**
    * 产出结构化的实施计划 (`implementation_plan.md`)。
    * 提交给用户审核，获得批准后方可执行。

3. **执行与任务分解 (Execution)**
    * 严格遵循“构思方案 → 提请审核 → 分解为具体任务”的顺序。
    * 任务应细化、可追踪。

## 3. 输出规范 (Output Guidelines)

适用于 AI 助手的严格输出规定：

* **语言要求**：
  * **全流程简体中文**。包括回复、思考过程、任务清单及文档注释。
* **格式要求**：
  * 每次回复开头必须包含模型信息（名称、版本）。
  * 使用结构化的 Markdown 格式。
* **固定指令**：
  * 任务开始时明确：`Implementation Plan, Task List and Thought in Chinese`。

## 4. 技术栈与编码规范 (Tech Stack)

* **框架**：Flutter (Dart)
* **代码风格**：
  * 遵循 [Dart 官方风格指南](https://dart.dev/guides/language/effective-dart) 及 `analysis_options.yaml` 配置。
  * 注重代码可读性，命名应准确清晰。
* **文档**：
  * 关键逻辑必须包含中文注释。
  * 文档优先（Docs as Code），变更代码前同步更新文档。

## 5. 项目管理 (Project Management)

* **轻量化管理**：
  * 使用 `docs/ROADMAP.md` 追踪长期目标。
  * AI 内部使用 `task.md` 追踪短期执行步骤。

## 6. Git 开发规范 (Git Standards)

* **元数据屏蔽 (Strict No-Metadata Policy)**
  * 提交信息必须 **纯净**。
  * **严禁** 包含 AI 模型名称、版本信息、思考过程或任何非业务相关的元数据。

* **Commit Message 格式**
  * 遵循 [Conventional Commits](https://www.conventionalcommits.org/) 标准。
  * **Header (英文)**: `<type>(<scope>): <subject>`
  * **Body (中文)**: 详细说明变更原因和内容。

* **Type 类型定义**
  * `feat`: 新功能 (Features)
  * `fix`: 修补 Bug (Bug Fixes)
  * `docs`: 文档变更 (Documentation)
  * `style`: 代码格式调整 (Styles)
  * `refactor`: 重构 (Code Refactoring)
  * `test`: 测试用例 (Tests)
  * `chore`: 构建过程或辅助工具变动 (Chores)

* **示例 (Example)**

    ```text
    feat(auth): add google sign-in support

    集成 Google 登录 SDK，完成基础配置与回调处理。
    ```
