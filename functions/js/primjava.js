'use strict';

const rp = require('request-promise-native');
var eredmeny = [2];

function isPrime(num) {
    for ( var i = 2; i < num; i++ ) {
        if ( num % i === 0 ) {
            return false;
        }
    }
    return true;
}

function display(n) {
    var arr = [2];
    for ( var i = 3; i < n; i+=2 ) {
        if ( isPrime(i) ) {
            arr.push(i);
        }
    }
    eredmeny = arr.pop();
}

module.exports = async function (context) {
    const stringBody = JSON.stringify(context.request.body);
    const body = JSON.parse(stringBody);
    const id = body.id;

	display(id);


    try {
        return {
            status: 200,
            body: {
              Eredmeny: `${eredmeny}` 
            },
            headers: {
                'Content-Type': 'application/json'
            }
        };
    } catch (e) {
        console.error(e);
        return {
            status: 500,
            body: e
        };
    }
}