# gitime-lapse
git(クローンURLから)からプログラミングタイムラプスを生成するプログラムです。
## 注意
- Windows10~のみ可能です。Mac・Linuxその他は使えません。
- リポジトリのコミット回数に比例(?)して時間がかかります。
- ウイルスに感染しても責任は取りません。自己責任で。
ちなみにvuejs/coreのpackages/reactivity/src/ref.tsを500x2000で出力したら16分かかりました
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