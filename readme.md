# gitime-lapse
git(クローンURLから)からプログラミングタイムラプスを生成するプログラムです。
## セットアップ
※自己責任です。ウイルスに感染しても責任は取りません。
1. [ffmpeg.org](https://ffmpeg.org/)からffmpegプログラムをダウンロードし、ffmpeg.exeをこのフォルダに移動してください。
2. gitをインストールしてください。
3. Powershellスクリプトの実行許可を与えてください。参考：[Windows PowerShell でスクリプトの実行を許可する方法](https://denno-sekai.com/windows-powershell-executionpolicy/)
## 実行
1. タイムラプスにしたいGitHubURL・ファイルパス・大きさ等を用意してください。
2. Powershellを起動してください。
3. このフォルダで`./gitime-lapse.ps1`を実行し、プロンプトに答えてから待ってください。
4. このフォルダの`./out.mp4`に結果が出力されます。