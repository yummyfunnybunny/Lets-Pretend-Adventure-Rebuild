{
  "$GMObject":"",
  "%Name":"obj_parent_crate",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":1,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_parent_crate",
  "overriddenProperties":[
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_parent_prop","path":"objects/obj_parent_prop/obj_parent_prop.yy",},"propertyId":{"name":"killable","path":"objects/obj_parent_prop/obj_parent_prop.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"True",},
  ],
  "parent":{
    "name":"Crates",
    "path":"folders/Objects/7 - Props/Crates.yy",
  },
  "parentObjectId":{
    "name":"obj_parent_prop",
    "path":"objects/obj_parent_prop/obj_parent_prop.yy",
  },
  "persistent":false,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[
    {"$GMObjectProperty":"v1","%Name":"max_hp","filters":[],"listItems":[],"multiselect":false,"name":"max_hp","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"1","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"max_armor","filters":[],"listItems":[],"multiselect":false,"name":"max_armor","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"damage_resistances","filters":[],"listItems":[],"multiselect":false,"name":"damage_resistances","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"damage_vulnerabilities","filters":[],"listItems":[],"multiselect":false,"name":"damage_vulnerabilities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"damage_immunities","filters":[],"listItems":[],"multiselect":false,"name":"damage_immunities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"element_resistances","filters":[],"listItems":[],"multiselect":false,"name":"element_resistances","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"element_vulnerabilities","filters":[],"listItems":[],"multiselect":false,"name":"element_vulnerabilities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"element_immunities","filters":[],"listItems":[],"multiselect":false,"name":"element_immunities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"buff_array","filters":[],"listItems":[],"multiselect":false,"name":"buff_array","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"debuff_array","filters":[],"listItems":[],"multiselect":false,"name":"debuff_array","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"item_drops","filters":[],"listItems":[
        "{ category: \"ammo\", item_id: 3, qty: 15, }",
      ],"multiselect":true,"name":"item_drops","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"{ category: \"ammo\", item_id: 3, qty: 15, }","varType":6,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":null,
  "spriteMaskId":null,
  "tags":[
    "destructible",
    "mobile",
  ],
  "visible":true,
}