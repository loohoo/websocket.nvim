# WebSocket.nvim 修复说明

## 问题
插件在 macOS Neovim 上运行时导致 SIGABRT crash。根本原因是 Tokio async runtime 与 Neovim 的 Lua VM 线程模型不兼容。

## 解决方案
不使用任何后台线程或异步 FFI。改为让用户在 Lua 中管理阻塞式连接。

## 修复步骤

### 1. 移除 Tokio Runtime
编辑 `rust/src/lib.rs`，移除全局 tokio runtime。

### 2. 实现同步 WebSocket API
- 客户端和服务器都使用阻塞式 I/O
- 用户在 Lua 中创建线程或使用定时器来避免阻塞

### 3. 使用标准库而非 Tokio

这需要完全重写 Rust 代码，从异步改为同步。

## 当前状态
禁用了 AsyncHandle::send()，但 Tokio runtime 仍在后台运行，导致仍有崩溃。

**最终解决方案**：完全移除异步运行时，改为同步阻塞式实现。
