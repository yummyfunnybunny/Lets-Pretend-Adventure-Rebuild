{
  "$GMObject":"",
  "%Name":"obj_parent_enemy",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":1,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":{"name":"obj_player","path":"objects/obj_player/obj_player.yy",},"eventNum":0,"eventType":4,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":2,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":3,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":4,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":8,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_parent_enemy",
  "overriddenProperties":[
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"shadow_index","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"8",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"shadow_always","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"True",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"entity_solid","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"False",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"z_height","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"16",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"z_gravity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"0",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"z_step_up","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"8",},
  ],
  "parent":{
    "name":"3 - Enemies",
    "path":"folders/Objects/3 - Enemies.yy",
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
    {"$GMObjectProperty":"v1","%Name":"_________parent_enemy___________","filters":[],"listItems":[],"multiselect":false,"name":"_________parent_enemy___________","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"sprite_idle","filters":[],"listItems":[],"multiselect":false,"name":"sprite_idle","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"sprite_move","filters":[],"listItems":[],"multiselect":false,"name":"sprite_move","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"sprite_attack","filters":[],"listItems":[],"multiselect":false,"name":"sprite_attack","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"sprite_death","filters":[],"listItems":[],"multiselect":false,"name":"sprite_death","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"damage","filters":[],"listItems":[],"multiselect":false,"name":"damage","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"1","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"max_hp","filters":[],"listItems":[],"multiselect":false,"name":"max_hp","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"3","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"hp_regen","filters":[],"listItems":[],"multiselect":false,"name":"hp_regen","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"max_mp","filters":[],"listItems":[],"multiselect":false,"name":"max_mp","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"mp_regen","filters":[],"listItems":[],"multiselect":false,"name":"mp_regen","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"max_armor","filters":[],"listItems":[],"multiselect":false,"name":"max_armor","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"armor","filters":[],"listItems":[],"multiselect":false,"name":"armor","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"max_armor","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"armor_regen","filters":[],"listItems":[],"multiselect":false,"name":"armor_regen","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"aggro_range","filters":[],"listItems":[],"multiselect":false,"name":"aggro_range","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"4","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"attack_range","filters":[],"listItems":[],"multiselect":false,"name":"attack_range","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"origin_range","filters":[],"listItems":[],"multiselect":false,"name":"origin_range","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"10","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"idle_weight","filters":[],"listItems":[],"multiselect":false,"name":"idle_weight","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"wander_weight","filters":[],"listItems":[],"multiselect":false,"name":"wander_weight","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"wait_weight","filters":[],"listItems":[],"multiselect":false,"name":"wait_weight","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"chase_weight","filters":[],"listItems":[],"multiselect":false,"name":"chase_weight","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"attack_weight","filters":[],"listItems":[],"multiselect":false,"name":"attack_weight","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"sleep_weight","filters":[],"listItems":[],"multiselect":false,"name":"sleep_weight","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"align_weight","filters":[],"listItems":[],"multiselect":false,"name":"align_weight","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"return_weight","filters":[],"listItems":[],"multiselect":false,"name":"return_weight","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"flee_weight","filters":[],"listItems":[],"multiselect":false,"name":"flee_weight","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"damage_resistances","filters":[],"listItems":[],"multiselect":false,"name":"damage_resistances","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"damage_vulnerabilities","filters":[],"listItems":[],"multiselect":false,"name":"damage_vulnerabilities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"damage_immunities","filters":[],"listItems":[],"multiselect":false,"name":"damage_immunities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"element_resistances","filters":[],"listItems":[],"multiselect":false,"name":"element_resistances","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"element_vulnerabilities","filters":[],"listItems":[],"multiselect":false,"name":"element_vulnerabilities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"element_immunities","filters":[],"listItems":[],"multiselect":false,"name":"element_immunities","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"buff_array","filters":[],"listItems":[],"multiselect":false,"name":"buff_array","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"debuff_array","filters":[],"listItems":[],"multiselect":false,"name":"debuff_array","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":0,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":null,
  "spriteMaskId":{
    "name":"spr_enemy_collision_mask",
    "path":"sprites/spr_enemy_collision_mask/spr_enemy_collision_mask.yy",
  },
  "visible":true,
}