<apex:page showHeader="false" standardStylesheets="false" doctype="html-5.0">
<html ng-app="myApp">
<head>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.6.1/angular.js"></script>
    <apex:stylesheet value="/resource/dapps_slds/assets/styles/salesforce-lightning-design-system-ltng.css"/>
	<apex:includeScript value="{!$Resource.web3_js}"/>
	<title>TimeKeeper Test</title>
	<script type="text/javascript">
		var Web3 = require('web3');
		if (typeof web3 !== 'undefined') {
		  web3 = new Web3(web3.currentProvider);
		} else {
		  // set the provider you want from Web3.providers
		  web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
		}

		var eth = web3.eth;
		var accounts = eth.accounts;
		var defaultAccount = accounts[0];
		eth.defaultAccount = defaultAccount;
    
    	function send(acc1,acc2,amt){
        	var txId = web3.eth.sendTransaction({
                        from: acc1, 
                        to: acc2, 
                        value: amt},function(error,result){
                        	console.log('result txId:'+result);
                        });
            console.log('txId:'+txId);
        }

        //var abi = [{"constant":true,"inputs":[],"name":"getDiff","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"diff","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"start","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"end","outputs":[],"payable":true,"type":"function"},{"inputs":[],"payable":false,"type":"constructor"}];
    	var abi = [{"constant":true,"inputs":[],"name":"getDiff","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"rate","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"getTotal","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"diff","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"start","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"target","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"end","outputs":[],"payable":false,"type":"function"},{"inputs":[{"name":"_rate","type":"uint256"}],"payable":false,"type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"from","type":"address"},{"indexed":false,"name":"to","type":"address"},{"indexed":false,"name":"amount","type":"uint256"}],"name":"Send","type":"event"}];

        //var _data = '0x6060604052341561000c57fe5b5b426000819055505b5b61012a806100256000396000f30060606040526000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680630b1bcee7146058578063a0d7afb714607b578063be9a655514609e578063efbe1c1c1460c1575bfe5b3415605f57fe5b606560d0565b6040518082815260200191505060405180910390f35b3415608257fe5b608860db565b6040518082815260200191505060405180910390f35b341560a557fe5b60ab60e1565b6040518082815260200191505060405180910390f35b341560c857fe5b60ce60e7565b005b600060025490505b90565b60025481565b60005481565b42600181905550600054600154036002819055505b5600a165627a7a72305820a2678f7621635411c730325805f7f0736f522b592e77585fbe3c04b49a6f64a90029';
        var _data = '0x6060604052341561000c57fe5b604051602080610463833981016040528080519060200190919050505b33600460006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550806003819055505b505b6103e0806100836000396000f3006060604052361561008c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680630b1bcee71461008e5780632c4e722e146100b4578063775a25e3146100da5780638da5cb5b14610100578063a0d7afb714610152578063be9a655514610178578063d4b839921461018a578063efbe1c1c146101dc575bfe5b341561009657fe5b61009e6101ee565b6040518082815260200191505060405180910390f35b34156100bc57fe5b6100c46101f9565b6040518082815260200191505060405180910390f35b34156100e257fe5b6100ea6101ff565b6040518082815260200191505060405180910390f35b341561010857fe5b61011061021b565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b341561015a57fe5b610162610241565b6040518082815260200191505060405180910390f35b341561018057fe5b610188610247565b005b341561019257fe5b61019a610292565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b34156101e457fe5b6101ec6102b8565b005b600060025490505b90565b60035481565b6000600354610e1060025481151561021357fe5b040290505b90565b600460009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b60025481565b33600560006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550426000819055505b565b600560009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b42600181905550600054600154036002819055507f93eb3c629eb575edaf0252e4f9fc0c5ccada50496f8c1d32f0f93a65a8257eb5600460009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16600560009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16600354604051808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001828152602001935050505060405180910390a15b5600a165627a7a7230582050fadef4ecf9b00e4ce833fdb8dd4c7b92a292c87f69f093923458ba1e87486f0029';

		var address = '0x9eacdcfa5b249fd4385e61b263abc6f3dc29e759';

		var _contractDef = eth.contract(abi);
		var _estimatedGasCreation;
		

		web3.eth.estimateGas({data: _data},
		    function(error,result){
		    	_estimatedGasCreation = result;
		    }
		);

		var myApp = angular.module('myApp',[]);
		function MyController($scope,$timeout){
			$scope.name = '';
			$scope.started = false;
			$scope.contractInstance;
			$scope.diff;
			$scope.getTimeEnable;
            $scope.endEnable;
            $scope.acc1 = defaultAccount;
            $scope.acc2;
            $scope.msg = [];
            $scope.rate = 9845699999989760;

			$scope.userList = [];
            
            //compiler
            $scope.compile = function(){
                
                console.log('###source code', $scope.sourcecode);
                var compiled = web3.eth.compile.solidity($scope.sourcecode, function(error,result){
    		    	console.log(error, result);
    		    	
    		    	var infoObj = result[Object.keys(result)[0]];
    		    	console.log('##infoObj', infoObj);
    		    	$scope.code = infoObj.code;
    		    	$scope.abi = JSON.stringify(infoObj.info.abiDefinition);
    		    	
    		    	$scope.$apply();
    		    	
    		    });
                 

            	
            }
            
            $scope.compiled = function(data){
                console.log(data); 
                
            }
            
            $scope.addMsg = function(msg){
            	$scope.msg.push(msg);
                // $scope.$apply();
            }
            $scope.create = function(){
                $scope.addMsg('Creating contract...');
            	_contractDef.new($scope.rate,
					{	
						from: $scope.acc1, 
						data: _data
					},
					function(error,result){
						if(result.address!=undefined && result.address!=null && result.address!=''){
							$scope.contractInstance = result;
                        	$scope.addMsg('Contract created at address:'+result.address);
                        	var sendEvent = $scope.contractInstance.Send();
                            sendEvent.watch(function(error,result){
                            	var args = result.args;
                                var from = args.from;
                                var to = args.to;
                                var amount = args.amount;
                                send(from,$scope.acc2,amount);
                                
                            });
                        	$scope.endEnable = true;
							$scope.$apply();
					}});
            }
 
			$scope.start = function(){
                
				$scope.started = true;
				$scope.contractInstance.start.sendTransaction({from : $scope.acc1},function(error,result){
					console.log('in start');
					console.log(error);
					console.log(result);
                    $scope.transactionId = '' || result;
					$scope.addMsg('Started, transaction ID :'+$scope.transactionId);
                    $scope.addMsg('Waiting to be mined..');
					
					$scope.checkTransaction($scope.transactionId);
				});

				
			}

			$scope.end = function(){
				$scope.ended = true;
				$scope.contractInstance.end.sendTransaction({from : $scope.acc1},function(error,result){
					console.log('in End');
					console.log(error);
					console.log(result);
					$scope.transactionId = '' || result;
                    $scope.addMsg('Ended, transaction ID :'+$scope.transactionId);
                    $scope.addMsg('Waiting to be mined..');
					$scope.checkTransaction($scope.transactionId,true);
				});
			};

			$scope.checkTransaction  = function(transactionId, isEnd){
				console.log('checkTransaction with transactionId:'+transactionId);
				web3.eth.getTransaction(transactionId,function(error,result){
					console.log('checkTransaction result:',result);
					if(!result.blockNumber){
						$timeout(function(){$scope.checkTransaction(transactionId,isEnd);}, 3000);
					}
					else{
						console.log('checkTransaction result: Enabled');
                        $scope.addMsg('Transaction with ID: '+transactionId + 'is mined');
						$scope.getTimeEnable = true;
                        
                        if(isEnd){
                        	$scope.getDiff();
                            // $scope.getTotal();
                        }
						$scope.$apply();
					}
				});
			}

			$scope.getDiff = function(){
				$scope.isDiff = true;
				$scope.contractInstance.getDiff.call({},function(error,result){
					console.log('in Diff');
					console.log(error);
                    $scope.diff = result.c[0];
                    $scope.addMsg('Time: ' + $scope.diff + ' seconds');
					
					$scope.$apply();
				});
			}
            $scope.getTotal = function(){
				$scope.isDiff = true;
				$scope.contractInstance.getTotal.call({},function(error,result){
					console.log('in total');
					console.log(error);
                    $scope.total = result.c[0];
                    $scope.addMsg('Total: ' + $scope.total + ' wei');
					$scope.$apply();
				});
			}
			
		}
		myApp.controller('MyController', MyController);

	</script>
</head>
<body ng-controller="MyController">
    <div class="dapps-slds"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <div>
        <h3 class="slds-text-title--caps slds-line-height--reset">Solidity Compiler</h3>
        <br/>
        <h3 class="slds-text-heading--large">
            Solidity Compiler
        </h3>
          
        
    </div>
        <br/>
    <div>
        <!--<div class="slds-form-element">-->
        <!--    Account 1: <input type="text" ng-model="acc1" class="slds-input" />-->
        <!--</div>-->
        <!--<br/>-->
        <!-- <div class="slds-form-element">-->
        <!--    Account 2: <input type="text" ng-model="acc2" class="slds-input"/>-->
        <!--</div>-->
        <!--<br/>-->
        <!--<div class="slds-form-element">-->
        <!--    Rate: <input type="number" ng-model="rate" class="slds-input" />-->
        <!--</div>-->
        
        <div class="slds-form-element">
          <label class="slds-form-element__label" for="textarea-input-01">Solidity Source Code</label>
          <div class="slds-form-element__control">
            <textarea id="textarea-input-01" class="slds-textarea" ng-model="sourcecode" placeholder="Enter your solidity code here"></textarea>
          </div>
        </div>
        
        <div class="slds-form-element">
          <label class="slds-form-element__label" for="textarea-input-01">Code</label>
          <div class="slds-form-element__control">
            <textarea id="textarea-input-01" class="slds-textarea" ng-model="code" placeholder=""></textarea>
          </div>
        </div>
        
        <div class="slds-form-element">
          <label class="slds-form-element__label" for="textarea-input-01">ABI</label>
          <div class="slds-form-element__control">
            <textarea id="textarea-input-01" class="slds-textarea" ng-model="abi" placeholder=""></textarea>
          </div>
        </div>
    </div>
	<div>
        <br/>
        <button class="slds-button slds-button--brand" ng-click="compile()">Compile</button>
		<!--<button class="slds-button slds-button--brand" ng-click="create()">Create</button>-->
  <!--      <button class="slds-button slds-button--neutral" ng-click="start()">-->
  <!--          <svg class="slds-button__icon slds-button__icon--left" aria-hidden="true">-->
  <!--  			<use xlink:href="/assets/icons/utility-sprite/svg/symbols.svg#download"></use>-->
  <!--			</svg>Start</button>-->
		<!--<button class="slds-button slds-button--neutral" ng-click="end()" ng-disabled = "!(started && contractInstance!=null && contractInstance!=undefined)">End</button>-->
		<!--<button ng-click="getDiff()" ng-disabled="!getTimeEnable">Get Time</button> -->
	</div>
	<div>
		<!--<div ng-if="started && (contractInstance==null || contractInstance==undefined)">
			Creating Contract.....
		</div>
		<div ng-if="started && contractInstance!=null && contractInstance!=undefined">
			Contract created at {{contractInstance.address}}
		</div> -->
       
		<!--<div ng-if="isDiff">
			Time : {{diff}} seconds
		</div> -->
        <br/>
        <h3>
            EVM Logs
        </h3>
        <ul class="slds-has-divider--top-space">
   			 <li class="slds-item" ng-repeat=" opt in msg track by $index" >
        		{{ opt }}
    		</li>
    </ul>
	</div>
    </div>
</body>
</html>
</apex:page>