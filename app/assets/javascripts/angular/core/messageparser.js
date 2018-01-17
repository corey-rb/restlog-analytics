'use strict';

function parse_messages(collection){

  var properties = [];
  var EVENT_DATA = 'event_data';

  if(collection.length > 0){
    _.each(collection, function(item){
      if(item[EVENT_DATA]){
        for(var rootName in item[EVENT_DATA]){
          //for(var rootName in root){

            if(_.indexOf(properties, rootName) < 0){
              properties.push(rootName);
            }
            //break; // this only gets the first item, we will work on a more robust parser
          //}
        }
      }
    });
  }

return properties;
}
