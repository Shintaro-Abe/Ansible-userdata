# Ansible-userdata
## 使用について

#### AmazonLinux2023は非対応。AmazonLinux2での使用を推奨。
amazon-linux-extrasを使用するため。

## スクリプトについて
以下の流れでインストールを実施し、インスタンスへ初めてログインした段階でAnsibleを使用できる環境を構築。
* __Ansibleのインストール__
* __RegionとOutoputの設定__
* __ansible.cfgの設定__
* __ansibleディレクトリの作成__

## コマンドについて
ユーザーデータはroot権限で実行する性質を持つため、ec2-userで実行したいコマンドには` sudo -u ec2-user -i `をつけて一時的にユーザーを変更。

