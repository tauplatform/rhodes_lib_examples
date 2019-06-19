
var server_port = Rho.System.NodejsServerPort

var path = require('path');
var express = require('express');
var app = express();

const https = require('http');

global.myfunc = function() {
    Rho.Log.info("$$$$$$$$$$$$$$$$$ RUN NODEJS CODE !!!", 'Node.js JS');
    Rho.WebView.executeJavascript("showAlert();");
};

global.myfunc01 = function() {
    Rho.Log.info("$$$$$$$$$$$$$$$$$ START RhoRuby Test 01 !!!", 'Node.js JS');
    Rho.RubyServer.loadModel("Model1");
    Rho.Log.info("$$ load Model1 finished", 'Node.js JS');
    Rho.RubyServer.executeRubyMethodWithJSON("Model1", "fillModelByPredefinedSet", "[]", function (par) {
        Rho.Log.info("$$ fill Model1 callback START-FINISH", 'Node.js JS');
    });
    Rho.Log.info("$$ fill Model1 finished", 'Node.js JS');
    Rho.Log.info("$$$$$$$$$$$$$$$$$ FINISH RhoRuby Test 01 !!!", 'Node.js JS');
};

global.myfunc02 = function() {
    Rho.Log.info("$$$$$$$$$$$$$$$$$ RUN RhoRuby Test 02 !!!", 'Node.js JS');
    Rho.RubyServer.loadModel("Model1");
    Rho.RubyServer.executeRubyMethodWithJSON("Model1", "getAllItemsAsHashes", "[]", function (par) {
        Rho.Log.info("$$ get Model1 callback START", 'Node.js JS');
        Rho.WebView.executeJavascript("showAlertWithText('"+par+"');");
        Rho.Log.info("$$ get Model1 callback FINISH", 'Node.js JS');
    });
    Rho.Log.info("$$ get Model1 executed", 'Node.js JS');
    Rho.Log.info("$$$$$$$$$$$$$$$$$ FINISH RhoRuby Test 02 !!!", 'Node.js JS');
};
global.myfunc03 = function() {
    console.log("C$$$$$$$$$$$$$$$$ RUN RhoRuby Test 03 !!!");
    Rho.Log.info("$$$$$$$$$$$$$$$$$ RUN RhoRuby Test 03 !!!", 'Node.js JS');
    url = Rho.RubyServer.serverURL + "/app/Model1/get_first_item_field_by_name?fieldName=attr1";
    Rho.Log.info("$$$$$$$$$$$$$$$$$ URL = ["+url+"]", 'Node.js JS');
    console.log("C$$$$$$$$$$$$$$$$$ URL = ["+url+"]");
    https.get(url, (resp) => {
      let data = '';

      // A chunk of data has been recieved.
      resp.on('data', (chunk) => {
          Rho.Log.info("$$$$$$$$$$$$$$$$$ received CHUNK = ["+chunk+"]", 'Node.js JS');
        data += chunk;
      });

      // The whole response has been received. Print out the result.
      resp.on('end', () => {
          Rho.Log.info("$$$$$$$$$$$$$$$$$ FINISH RhoRuby Test 03 RECEIVED DATA>>>>>>>", 'Node.js JS');
          Rho.Log.info(data, 'Node.js JS');
          console.log("C data = ["+data+"]");
          Rho.Log.info("$$$$$$$$$$$$$$$$$ FINISH RhoRuby Test 03 RECEIVED DATA<<<<<<<", 'Node.js JS');
      });

    }).on("error", (err) => {
      Rho.Log.error("RhoRuby Test 03 RECEIVED ERROR: " + err.message, 'Node.js JS');
      console.log("C RECEIVED ERROR: " + err.message);
    });
    Rho.Log.info("$$$$$$$$$$$$$$$$$ FINISH RhoRuby Test 03 !!!", 'Node.js JS');
};
global.myfunc04 = function() {
    Rho.Log.info("$$$$$$$$$$$$$$$$$ RUN RhoRuby Test 04 !!!", 'Node.js JS');
};
global.myfunc05 = function() {
    Rho.Log.info("$$$$$$$$$$$$$$$$$ RUN RhoRuby Test 05 !!!", 'Node.js JS');
};


app.use('/public', express.static(path.join(__dirname, 'public')));

app.get('/', function (req, res) {
  res.send('Hello World! (' + Date.now() + ")");
});

var server = app.listen(server_port, function () {
  Rho.Log.info("Express server is started. (port: "+server_port+")", "Node.js JS");
  // application must be inform RHomobile platform about starting of http server !
  Mobile.httpServerStarted();


});
