pragma solidity ^0.8.7;


contract SaleProduct 
{
    address proprio;
    struct Vendeur {
        string nom_produit;
        uint prix;
        uint quantite;
    }
    struct acheteur {
        string[] produitacheter;
    }
    constructor() {
        proprio = msg.sender;
    }
    mapping (address => Vendeur) Vendeurs;
    mapping (address => acheteur) acheteurs;

    function ajouterproduit(string memory _nom_produit,uint _prix, uint _quantite) public 
    {
        require(Vendeurs[msg.sender].quantite==0, "vous vendez deja des produits.");
        Vendeurs[msg.sender].nom_produit = _nom_produit;
        Vendeurs[msg.sender].prix =_prix;
        Vendeurs[msg.sender].quantite =_quantite;

    }
    function getinfoproduct(address addresse) public view returns (Vendeur memory) {
        return Vendeurs[addresse];
    }
    function acheterproduit(address addresse) public payable 
    {
        require(msg.value >= Vendeurs[addresse].prix, "montant insuffisant");
        require(Vendeurs[addresse].quantite >0, "quantite insuffisante");
        Vendeurs[addresse].quantite--;
        acheteurs[msg.sender].produitacheter.push(Vendeurs[addresse].nom_produit);


    }
    function return_buyed_product() public view returns (string[] memory) 
    {
        return acheteurs[msg.sender].produitacheter;
    }
    
}

