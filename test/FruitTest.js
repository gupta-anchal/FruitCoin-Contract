const FruitCoin = artifacts.require("FruitCoin");

contract("FruitCoin", accounts => {

    let FruitCoinInstance;

    beforeEach(async () => {
        FruitCoinInstance = await FruitCoin.deployed();
    })
    
    it("admin should be able to mint tokens", async () => {
        const admin = accounts[0];
        await FruitCoinInstance.mint(admin,(100 * (10**18)).toString());
        const expectedBalance = (200 * (10**18));
        const actualBalance = await FruitCoinInstance.balanceOf(admin);
        assert.equal(actualBalance,expectedBalance);
    })

    it("user should not be able to mint tokens", async () => {
        const user = accounts[1];
        try {
            await FruitCoinInstance.mint(user,(100 * (10**18)).toString() , {from: user});
        }
        catch(err) {
        }
        const expectedBalance = (0 * (10**18));
        const actualBalance = await FruitCoinInstance.balanceOf(user);
        assert.equal(actualBalance,expectedBalance);
    })

    it("should not mint more than 10000 tokens", async () => {
        const admin = accounts[0];
        try{
            await FruitCoinInstance.mint(admin,(10000 * (10**18)).toString());
        }       
        catch(err) {
        } 
        const expectedBalance = (100 * (10**18)).toString();
        const actualBalance = await FruitCoinInstance.balanceOf(admin);
        assert.equal(actualBalance.toString(),expectedBalance);
    })

    it("burn should be only called by admin")
    it("mint should be only called by admin")
    it("total supply should not exceed 10000")
    it("user must be a part of TokenList if balance is more than 0")
    it("user should not be a part of TokenList if balance is less than or equal to 0")


});
