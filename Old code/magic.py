import smallgame



class magic:
#This class is used as a basis for all the spells that are going to be created.
	def __init__(self, cost = 0, damage = 0, effect = None, lingering = False, move = 0, mana_type = "Grey", description = ""):
		
		self.cost = cost
		self.damage = damage
		self.effect = effect
		self.lingering = lingering
		self.move = move
		self.mana_type = mana_type
		self.description = description

class Attunement:
	#This class will be used to code in all the attunements and their functions
	Shrouds = {"Quartz": [0,0,0], "Carnelian": [0.15, 0.30, 0.30], "Sunstone": [0.30, 0.60, 0.60], "Citrine": [0.45, 0.90, 0.90], "Emerald": [0.60, 1.20, 1.20], "Sapphire": [0.75, 1.50, 1.50]}
	
	def __init__(self, name = None, Primary = None, Secondary = None, Tertiary = None, Quarternary = None, location = None):
		
		self.name = name
		self.Primary = Primary
		self.Secondary = Secondary
		self.Tertiary = Tertiary
		self.Quarternary = Quarternary

		self.location = location
		self.mana = smallgame.Character.mana[self.location]

		if self.mana < 60:
			self.rank = "Quartz"

		elif self.mana < 360:
			self.rank = "Carnelian"

		elif self.mana < 2160:
			self.rank = "Sunstone"

		elif self.mana < 12960:
			self.rank = "Citrine"

		elif self.mana < 77760:
			self.rank = "Emerald"

		else:
			self.rank = "Sapphire"

		self.shroud = Attunement.Shrouds[self.rank]

	
	def __repr__(self):
		return self.name

	def Lightning_Boost():
		#This code will make lightning spells do more damage

	def update_attune(self):

		self.mana = smallgame.Character.mana[self.location]
		if self.mana < 60:
			self.rank = "Quartz"

		elif self.mana < 360:
			self.rank = "Carnelian"

		elif self.mana < 2160:
			self.rank = "Sunstone"

		elif self.mana < 12960:
			self.rank = "Citrine"

		elif self.mana < 77760:
			self.rank = "Emerald"

		else:
			self.rank = "Sapphire"
		self.shroud = Shrouds[self.rank]


if __name__ == "__main__":

	Elementalist = Attunement(name = "Elementalist", Primary = "Fire", Secondary = "Air", location = "Right Hand")
	smallgame.Character.attunements.append(Elementalist)

	print(smallgame.Character.hp)
	print(smallgame.Character.atk)
	print(smallgame.Character.defs)
	print(smallgame.Character.mana)
	print(smallgame.Character.attunements)
	
	
	for mark in smallgame.Character.attunements:
		print(mark.rank)
		print(mark.mana)
		print(mark.location)

		input("Press Enter to continue...")