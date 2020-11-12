module.exports = function(callback) {
    SimpleStorage.deployed().then((instance)=>{app = instance;})
    app.set(56) 
    app.get() 
}
