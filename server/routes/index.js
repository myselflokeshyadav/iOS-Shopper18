var express = require('express');
var router = express.Router();
var braintree = require("braintree");

var gateway = braintree.connect({
    environment:  braintree.Environment.Sandbox,
    merchantId:   'rjfzp4tsz8yj8kz2',
    publicKey:    '62n53trh6p39pqyb',
    privateKey:   '29bfbd4259a6a44a467f3b83603e5c67'
});

/* GET home page. */
router.get('/token', function(req, res, next) {
  gateway.clientToken.generate({}, function (err, response) {
    res.send(response.clientToken);
    //res.json(response);
  });
});


router.post("/payment", function (req, res) {

var sale = {
  //amount: '10',
  amount : req.param('amount'),
  //payment_method_nonce: req.param('payment_method_nonce')
  payment_method_nonce: 'fake-valid-nonce'
}

gateway.transaction.sale(sale, function(error, response){
  if(!error && response.success){
    res.json(response);
  }else{
    //show error message
  }
  });

});


module.exports = router;
