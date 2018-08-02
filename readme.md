# win-ime-con.nvim
WindowsのNeoVimで、モード変更時にIME状態を自動で切り替えるプラグインです。  
nvim-qt.exeやTerminal上のnvim.exeで動作します。  

## 動作条件
- Windows10 Home 64bit（他の環境では動作未検証）
- Pythonインターフェイスが有効（`:echo has('python3')` で `1` が表示される）
- `> pip3 install neovim` を実行済み

## オプション
デフォルトではノーマルモード移行時にはIMEをOFFに、挿入モード移行時には以前のIME状態を復元します。  
`g:win_ime_con_mode=0` にすると、常にIMEをOFFの状態で挿入モードに移行します。
