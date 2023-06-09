# Ansible-userdata
## 使用について

* __AmazonLinux2023は非対応。AmazonLinux2での使用を推奨。__
    * amazon-linux-extrasを使用するため。
* __EC2のインスタンスプロファイルにIAMロールを設定。__
    * リソースの作成に必要な権限を付与。
    * パラメータ取得のため、` ssm:GetParameter `ポリシーが必要。 
## スクリプトについて
以下の流れでインストールを実施し、インスタンスへ初めてログインした段階でAnsibleを使用できる環境を構築。
* __SystemsManager ParameterStoreからパラメータの取得__
* __Ansibleのインストール__
* __RegionとOutputの設定__
* __ssh公開鍵と秘密鍵の生成__
* __ansible-vaultによる鍵の暗号化__
* __ansible.cfgの設定__
* __ansibleディレクトリの作成__

## コマンドについて
* __権限の変更__
    * root権限で実行する性質を持つため、ec2-userで実行したいコマンドには` sudo -u ec2-user -i `、もしくは` sudo -u ec2-user `をつけて一時的にユーザーを変更。

* __SystemsManager ParameterStoreのパラメータ取得__
    * variableに` ssm get-parameter `コマンドで取得した値が入るので、スクリプトでパラメータを参照する箇所に` $variable `の形式で記述。
    * パラメータのタイプはString、SecureString関係なく使用可能。
```
variable=$(aws ssm get-parameter --name "parameter_name" --with-decryption --region current_region  --output text --query Parameter.Value)
```

## playbookについて
サンプルのデータもインストールする場合は、` sudo -u ec2-user -i mkdir ansible `の箇所を以下のコマンドへ修正して使用。
```
sudo -u ec2-user -i wget https://github.com/Shintaro-Abe/Ansible/archive/refs/heads/main.zip
sudo -u ec2-user -i unzip main.zip
sudo -u ec2-user -i rm main.zip
```
playbookの実行は、Ansible-mainディレクトリへ移動の上、以下のコマンドを使用。
```
ansible-playbook -i hosts.ini main.yml
```
データについては、以下のリポジトリを参照。

<a href="https://github.com/Shintaro-Abe/Ansible.git"><img src="https://img.shields.io/badge/ShintaroAbe/Ansible-181717.svg?logo=github&style=flat-square"></a>
