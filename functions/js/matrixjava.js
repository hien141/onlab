'use strict';

const rp = require('request-promise-native');
var eredmeny = [3][3];

function multiply(a, b) {
    var aNumRows = a.length, aNumCols = a[0].length,
        bNumRows = b.length, bNumCols = b[0].length,
        m = new Array(aNumRows);  // initialize array of rows
    for (var r = 0; r < aNumRows; ++r) {
      m[r] = new Array(bNumCols); // initialize the current row
      for (var c = 0; c < bNumCols; ++c) {
        m[r][c] = 0;             // initialize the current cell
        for (var i = 0; i < aNumCols; ++i) {
          m[r][c] += a[r][i] * b[i][c];
        }
      }
    }
    return m;
}



module.exports = async function (context) {
    const stringBody = JSON.stringify(context.request.body);
    const body = JSON.parse(stringBody);
    const id = body.id;

    var a = [[8, 3], [2, 4], [3, 6]],
    b = [[1, 2, 3], [4, 6, 8]];

    eredmeny = multiply(a, b);

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