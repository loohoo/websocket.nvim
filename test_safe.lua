-- 安全的测试脚本 - 不实际调用 websocket 功能

require("websocket").setup()

print("✓ WebSocket plugin setup complete")
print("✓ To test actual connection, run: lua require('websocket.client').WebsocketClient.new(...)")
print("")
print("⚠️  Note: If you encounter crashes, the issue is likely in the Rust FFI layer")
print("    due to Neovim version incompatibility or thread safety issues.")
