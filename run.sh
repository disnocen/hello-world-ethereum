#!/bin/sh

install_command="sudo pacman -Suy" # in Debian/Ubuntu/... "sudo apt install"   
term_command="st -e" # "xterm -e"  
shell_conf_file=".bashrc"  # ".zshrc"  
copy_command="xclip -i -selection clipboard"  # "xsel -b"  

ganache_def_port=8546
ganache_accounts_number=5

install() {
    # you can change xclip with xsel, but you
    # also need to change the $copy_command
    for in in npm jq xclip 
    do
        which $i || pinstall $i
    done

    for i in geth truffle ganache-cli
    do
        npm install $i
    done

    export PATH=$HOME/node_modules/.bin/:$PATH
    echo 'export PATH=$HOME/node_modules/.bin/:$PATH' >> $HOME/$shell_conf_file
}

run() {
    echo "Starting a local blockchain with ganache-cli..."  
    $term_command ganache-cli -a $ganache_accounts_number -p $ganache_def_port &
    sleep 10
    truffle migrate --network development 
    cat build/contracts/SimpleStorage.json |jq .abi|tr -d "\n"|tr -d " "|$copy_command
    cat << EOF
ABI of the SimpleStorage contract has been copied to the cliboard.
Now do these steps to start interactin with the contract:
1. In the geth console write: 
> SimpleStorageABI=
and then paste the ABI and press Enter
2. In the geth console write: 
> SimpleStorageAddress="put_the_transaction_hash_here"
3. Press Enter and then do this command:
> SimpleStorageContract=eth.contract(SimpleStorageABI).at(SimpleStorageAddress)

The contract has two functions:
+ set(): sets a number in the storage (this requires eth) 
+ get(): reads from the blockchain the value (this is free) 

You can use the set function in the geth console and put the number 10 by doing:
> SimpleStorageContract.set(10, {from: eth.accounts[0]})

You can read the number stored by doing:
> SimpleStorageContract.get() 
EOF
    $term_command geth attach http://127.0.0.1:$ganache_def_port & 1>/dev/null
}

console() {
    truffle console
    # SimpleStorage.deployed().then((instance)=>{app = instance;})
    # app.set(56) 
    # app.get() 

} 

case $1 in 
    install) install ;;
    run) run ;;
    console) console ;;
    *) 
        install 
        run 
        ;;
esac
