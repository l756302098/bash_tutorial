#!/bin/bash
default_workspace=/home/workspace/
echo $default_workspace

install_to_path()
{
    echo "default install start"
    echo $1
    if [ -d $run_dir ];
    then
        echo '$1 is path.' 
    else
        echo '$1 not exist.'
        exit 1
    fi
    run_dir=$1/run/
    scripts_dir=$1/scripts/
    submodules_dir=$1/submodules/
    echo $run_dir
    echo $scripts_dir
    if [ -d $run_dir ];
    then
        echo 'exists ' 
    else
        echo 'not exists '
        mkdir -p $run_dir
    fi
    cp ../run/*.yaml $run_dir

    if [ -d $scripts_dir ];
    then
        echo 'exists ' 
    else
        echo 'not exists '
        mkdir -p $scripts_dir
    fi
    cp ../scripts/*.sh $scripts_dir

    if [ -d $submodules_dir ];
    then
        echo 'exists ' 
    else
        echo 'not exists '
        mkdir -p $submodules_dir
    fi
    cp -a ../submodules/* $submodules_dir

    echo "default install finish."
}

uninstall()
{
    echo "uninstall"
    rm -f $default_workspace/run/*.yaml
    rm -f $default_workspace/scripts/*.sh
    rm -rf $default_workspace/submodules/*
    echo "uninstall finish."
}

install()
{
    echo "install"
    echo "install finish."
}

init_service()
{
    echo "init service start"
    SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    echo "scripts path: $SCRIPTS_DIR"

    # 放置守护进程脚本
    cd $SCRIPTS_DIR
    cp new_service.sh  /etc/init.d/

    # 设置自启动
    cd /etc/init.d/
    # update-rc.d new_service.sh defaults 90
    mv new_service.sh S99new_service.sh
    echo "init service finish."
}

remove_service()
{
    echo "remove service start"
    SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    echo "scripts path: $SCRIPTS_DIR"

    # 设置自启动
    cd /etc/init.d/
    rm S99new_service.sh
    cd -
    echo "remove service finish."
}

usage()
{
    echo "usage:"
    echo "       ./install.sh -p /root/workspace(your path)"
    echo "       or"
    echo "       ./install.sh -u (uninstall)"
    echo "       or"
    echo "       ./install.sh -i(/etc/init.d)"
    echo "       or"
    echo "       ./install.sh -r(/etc/init.d)"
}

if [ $# -eq 0 ];
then
    install_to_path $default_workspace
else
    while getopts "p:huir" ARGS  
    do  
    case $ARGS in 
        h)
            usage
            ;;
        u)
            echo "uninstall"
            uninstall
            ;;
        p)
            echo "custom install"
            install_to_path $1
            ;; 
        i)
            echo "set /etc/init.d"
            remove_service
            init_service
            ;; 
        r)
            echo "remove /etc/init.d"
            remove_service
            ;; 
    esac
    done
fi

exit 0


