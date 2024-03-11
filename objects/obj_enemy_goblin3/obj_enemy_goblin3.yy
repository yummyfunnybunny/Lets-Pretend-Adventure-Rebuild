{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_enemy_goblin3",
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":{"name":"obj_player","path":"objects/obj_player/obj_player.yy",},"eventNum":0,"eventType":4,"isDnD":false,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,},
  ],
  "managed": true,
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"z_height","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"value":"24",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_enemy","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"propertyId":{"name":"sprite_move","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"value":"spr_goblin3_move",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_enemy","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"propertyId":{"name":"sprite_death","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"value":"spr_goblin3_death",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_enemy","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"propertyId":{"name":"sprite_attack","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"value":"spr_goblin3_attack",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"run_speed","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"value":"2",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"climb_speed","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"value":"0",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"wade_speed","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"value":"0",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"walk_speed","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"value":".5",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_enemy","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"propertyId":{"name":"sprite_idle","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"value":"spr_goblin3_idle",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_enemy","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"propertyId":{"name":"idle_weight","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"value":"2",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_enemy","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"propertyId":{"name":"wander_weight","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"value":"3",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_enemy","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"propertyId":{"name":"aggro_range","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"value":"15",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_entity","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"propertyId":{"name":"knockback_amount","path":"objects/obj_parent_entity/obj_parent_entity.yy",},"value":"8",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_enemy","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"propertyId":{"name":"origin_range","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"value":"20",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_enemy","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"propertyId":{"name":"max_hp","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"value":"3",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_parent_enemy","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"propertyId":{"name":"attack_range","path":"objects/obj_parent_enemy/obj_parent_enemy.yy",},"value":"10",},
  ],
  "parent": {
    "name": "Enemies",
    "path": "folders/Objects/Enemies.yy",
  },
  "parentObjectId": {
    "name": "obj_parent_enemy",
    "path": "objects/obj_parent_enemy/obj_parent_enemy.yy",
  },
  "persistent": false,
  "physicsAngularDamping": 0.1,
  "physicsDensity": 0.5,
  "physicsFriction": 0.2,
  "physicsGroup": 1,
  "physicsKinematic": false,
  "physicsLinearDamping": 0.1,
  "physicsObject": false,
  "physicsRestitution": 0.1,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsShapePoints": [],
  "physicsStartAwake": true,
  "properties": [],
  "solid": false,
  "spriteId": {
    "name": "spr_goblin2_idle",
    "path": "sprites/spr_goblin2_idle/spr_goblin2_idle.yy",
  },
  "spriteMaskId": {
    "name": "spr_goblin1_idle",
    "path": "sprites/spr_goblin1_idle/spr_goblin1_idle.yy",
  },
  "visible": true,
}