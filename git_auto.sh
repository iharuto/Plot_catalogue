#!/bin/bash

# ssh-agentの起動とsshキーの追加
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "初期化しています..."
    (umask 066; ssh-agent > "${SSH_ENV}")
    source "${SSH_ENV}" > /dev/null
    ssh-add
}

# ssh-agentの状態をチェックし、必要に応じて起動
if [ -f "${SSH_ENV}" ]; then
    source "${SSH_ENV}" > /dev/null
    # ssh-agentのプロセスIDが生きているか確認
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# "$@"を使ってすべての引数を処理する
for FILE_OR_DIR in "$@"
do
    # git add
    git add "$FILE_OR_DIR"
done

# git commit
git commit -m "updated"

# git push
git push
