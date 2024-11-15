{
  "$GMObject":"",
  "%Name":"obj_parent_prop",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":8,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":1,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":2,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":3,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_parent_prop",
  "overriddenProperties":[
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"entity_solid","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"True",},
  ],
  "parent":{
    "name":"7 - Props",
    "path":"folders/Objects/7 - Props.yy",
  },
  "parentObjectId":{
    "name":"obj_parent_entity",
    "path":"objects/obj_parent_entity/obj_parent_entity.yy",
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
    {"$GMObjectProperty":"v1","%Name":"can_kill","filters":[],"listItems":[],"multiselect":false,"name":"can_kill","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"can_harm","filters":[],"listItems":[],"multiselect":false,"name":"can_harm","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"can_move","filters":[],"listItems":[],"multiselect":false,"name":"can_move","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"can_spawn","filters":[],"listItems":[],"multiselect":false,"name":"can_spawn","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"can_interact","filters":[],"listItems":[],"multiselect":false,"name":"can_interact","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"can_float","filters":[],"listItems":[],"multiselect":false,"name":"can_float","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"can_drop_items","filters":[],"listItems":[],"multiselect":false,"name":"can_drop_items","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"max_hp","filters":[],"listItems":[],"multiselect":false,"name":"max_hp","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"max_armor","filters":[],"listItems":[],"multiselect":false,"name":"max_armor","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"damage_resistances","filters":[],"listItems":[
        "DAMAGE_TYPE.SLASH",
        "DAMAGE_TYPE.PIERCE",
        "DAMAGE_TYPE.BLUNT",
        "DAMAGE_TYPE.EXPLOSION",
      ],"multiselect":true,"name":"damage_resistances","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"damage_vulnerabilities","filters":[],"listItems":[
        "DAMAGE_TYPE.SLASH",
        "DAMAGE_TYPE.PIERCE",
        "DAMAGE_TYPE.BLUNT",
        "DAMAGE_TYPE.EXPLOSION",
      ],"multiselect":true,"name":"damage_vulnerabilities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"damage_immunities","filters":[],"listItems":[
        "DAMAGE_TYPE.SLASH",
        "DAMAGE_TYPE.PIERCE",
        "DAMAGE_TYPE.BLUNT",
        "DAMAGE_TYPE.EXPLOSION",
      ],"multiselect":true,"name":"damage_immunities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"element_resistances","filters":[],"listItems":[],"multiselect":false,"name":"element_resistances","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"element_vulnerabilities","filters":[],"listItems":[],"multiselect":false,"name":"element_vulnerabilities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"element_immunities","filters":[],"listItems":[],"multiselect":false,"name":"element_immunities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"buff_array","filters":[],"listItems":[],"multiselect":false,"name":"buff_array","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"debuff_array","filters":[],"listItems":[],"multiselect":false,"name":"debuff_array","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"item_drops","filters":[],"listItems":[
        "{ category: \"ammo\", item_id: 3, qty: 15, }",
      ],"multiselect":true,"name":"item_drops","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"locked","filters":[],"listItems":[],"multiselect":false,"name":"locked","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"interact_type","filters":[],"listItems":[],"multiselect":false,"name":"interact_type","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"INTERACT_TYPE.NONE","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"interact_range","filters":[],"listItems":[],"multiselect":false,"name":"interact_range","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"1.5","varType":0,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":null,
  "spriteMaskId":null,
  "visible":true,
}