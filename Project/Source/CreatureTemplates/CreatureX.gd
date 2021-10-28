extends Node2D

class_name creatureX


enum STAT {
	MAX_HP, #0
	HP, #1
	MAX_ENERGY,#2
	ENERGY, #3
	MAX_RESOURCE,#4 
	RESOURCE,#5
	ATK, #6
	SPATK, #7
	DEF, #8
	SPDEF, #9
	SPD#10
	} ;

var creatureData ;
var creatureName ;
var creatureNickname ;

var level ;
var experience: int ;
var experience_needed: int ;
var experience_given: int ;
#this allows enemies to split their exp to your party members
var enemy_experience_tracker = [] ;

var spriteSheet ;

var resourceType ;
var creatureType = [] ; #need to define as array to use append

var stat = [null,null,null,null,null,null,null,null,null,null,null] ;
var stat_mult = [null,null,null,null,null,null,null,null,null,null,null]

var moveList = [] ;

var moveEffects = [] ; #this will keep track of effects such as poison
var targetEffects = [] ; #this will help an aether creatures find their aether 
var resourceToDistribute = [] ;

signal UpdatePlayerUI(myself) 
signal UpdatePlayerUI_Fainted(myself);

signal UpdateEnemyUI(myself) ;
signal UpdateEnemyUI_Fainted(myself);

signal UpdateTargetingUI_Fainted(myself) ;

func initializeStats(creature, set_level) : #the creature manager will handle this
	creatureData = creature ;
	creatureData.initialize(self, set_level) ;
	stat_mult = [1,1,1,1,1,1,1,1,1,1,1] ;
	level=set_level ;
	experience = 0 ;
	experience_needed = int(6 * pow(( 1 + 0.20), level)) ;
	experience_given = int(6 * pow(( 1 + 0.20), level) /2) ; 
	self.visible = false ;

# warning-ignore:function_conflicts_variable
func moveList():
	var moves = [] ;
	for m in moveList.size():
		moves.append(moveList[m].skillName) ;
	return moves ;


func updateHP(damage_source, damage): #check for fainted here
	stat[STAT.HP] -= damage ;
	BattleLog.updateBattleLog(creatureName + " took " + String(damage)) ;
	
	var my_parent = get_parent().get_parent() ;
	
	#should be in update resource
	if resourceType.resourceName == "Rage":
		#you get %rage bar of 2 * %damage done to health
		#ie you get 2 full rage bars assuming no healing is done, and no overcapping
		var addRec = int( (stat[STAT.MAX_RESOURCE] * 2 * damage / stat[STAT.MAX_HP] ) );
		var rageCap = stat[STAT.MAX_RESOURCE] - stat[STAT.RESOURCE] ;
		print("updateHP() maxHP: ", stat[STAT.MAX_HP])
		print("updateHP() damage: ", damage)
		print("updateHP() addRec: ", addRec) ;
		stat[STAT.RESOURCE] += clamp(addRec,1,rageCap) ;
	
	if my_parent.name == "Enemy":
		emit_signal("UpdateEnemyUI", self) ;
	else:
		emit_signal("UpdatePlayerUI", self) ;
		
	if stat[STAT.HP] <= 0:
		fainted(damage_source) ;

func fainted(_damage_source):
	BattleLog.updateBattleLog(creatureName + " fainted") ;
	
	var my_parent = get_parent().get_parent() ;
	var myIndex = my_parent.battleTeam.find(self) ;
	my_parent.battleTeam[myIndex] = null ;
	
	var list_size = enemy_experience_tracker.size() - 1 ;
	for creature in enemy_experience_tracker.size():
		if enemy_experience_tracker[list_size - creature].get_parent().name == "Fainted":
			enemy_experience_tracker.remove(list_size - creature) ;
	
	#now distribute experience to remaining player creatures that saw you
	for creature in enemy_experience_tracker.size():
		enemy_experience_tracker[creature].gainExp(ceil(experience_given/enemy_experience_tracker.size())+1) ;
	
	for effect in moveEffects:
		effect.destory() ;
	
	if my_parent.name == "Enemy":
		my_parent.get_node("Party").remove_child(self) ;
		queue_free() ;
		emit_signal("UpdateEnemyUI_Fainted", self) ;
		emit_signal("UpdateTargetingUI_Fainted", self) ;
	else:
		my_parent.get_node("Party").remove_child(self) ;
		my_parent.get_node("Fainted").add_child(self) ;
		emit_signal("UpdatePlayerUI_Fainted", self) ;
		emit_signal("UpdateTargetingUI_Fainted", self) ;
	

func gainExp(experience_gain) :
	experience += experience_gain ;
	BattleLog.updateBattleLog(creatureName + " gained " + String(experience_gain) + " exp") ;
	
	
	
	
	if(experience >= experience_needed):
		levelUp() ;
	else:
		if get_parent().get_parent().name == "Enemy":
			emit_signal("UpdateEnemyUI", self) ;
		else:
			emit_signal("UpdatePlayerUI", self) ;
	

func levelUp():
	level += 1 ;
	BattleLog.updateBattleLog(creatureName + " grew to level " + String(level)) ;
	var cur_exp = experience - experience_needed ;
	experience_needed = int(6 * pow(( 1 + 0.20), level)) ;
	experience_given = int(6 * pow(( 1 + 0.20), level) /2) ; 
	experience = cur_exp ;
	creatureData.levelUp(self, level) ;
	
	if get_parent().get_parent().name == "Enemy":
		emit_signal("UpdateEnemyUI", self) ;
	else:
		emit_signal("UpdatePlayerUI", self) ;
	
	

func getResource(resourceName):
	if resourceName == "Energy":
		return stat[STAT.ENERGY] ;
	else:
		return stat[STAT.RESOURCE] ;

func updateResource(resourceCost, resourceName):
	if resourceName == "Energy":
		stat[STAT.ENERGY] -= resourceCost ;
		if stat[STAT.ENERGY] < 0:
			stat[STAT.ENERGY] = 0 ;
	else:
		stat[STAT.RESOURCE] -= resourceCost ;
		if stat[STAT.RESOURCE] < 0:
			stat[STAT.RESOURCE] = 0 ;
	
	if get_parent().get_parent().name == "Enemy":
		emit_signal("UpdateEnemyUI", self) ;
	else:
		emit_signal("UpdatePlayerUI", self) ;

func sortSpd(creatureA, creatureB):
	if creatureA.stat[STAT.SPD] >= creatureB.stat[STAT.SPD]:
		return true;
	else:
		return false ;
	

func UpdateEnemyUI_Caught() :
	emit_signal("UpdateEnemyUI_Fainted", self) ;
func UpdateTargetingUI_Caught() :
	emit_signal("UpdateTargetingUI_Fainted", self) ;

func resolveEffects():
	for effects in moveEffects:
		if effects.has_method("destroy"):
			effects.destroy() ;
		moveEffects.erase(effects) ;
	
	for effects in targetEffects:
		targetEffects.erase(effects) ;
