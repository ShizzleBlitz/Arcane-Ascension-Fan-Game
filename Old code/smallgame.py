import random

class Player:
	buffs = []

	def __init__(self, attunements = []):
		self.hp = random.randint(80,120)
		self.atk = random.randint(10,14)
		self.defs = random.randint(10,14)
		self.attunements = attunements

		for marks in attunements:
			self.hp += self.hp*marks.shroud[0]
			self.atk += self.atk*marks.shroud[1]
			self.defs += self.defs*marks.shroud[2]

			self.manatypes.append(marks.Primary)
			self.manatypes.append(marks.Secondary)
			
			if marks.mana >= 360:
				self.manatypes.append(marks.Quarternary)
				
				if marks.mana >= 2160:
					self.manatypes.append(marks.Tertiary)
				


		self.mana = {"Mind": random.randint(1,20), "Right Hand": random.randint(1,20), "Left Hand": random.randint(1,20), "Right Leg": random.randint(1,20), "Left Leg": random.randint(1,20), "Heart": random.randint(1,20), "Lungs": random.randint(1,20)}

	def update_player(self):
		pass

Character = Player()