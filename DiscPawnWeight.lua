
SLASH_DISCPAWN1 = '/discpawn'; -- 3.

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function SlashCmdList.DISCPAWN(msg, editbox) -- 4.
  hasterating = 375
  critrating = 400
  masteryrating = (1000/3.75)
  versrating = 475
  local intellect = UnitStat('player', 4)
  local haste = GetHaste() * hasterating
  local crit = GetSpellCritChance(2) * critrating
  local mastery = GetMastery() * masteryrating
  local vers = (GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE)) * versrating
  local critpun = 1
  local baseatonment = 0.75
  intellect = intellect + 1300

  intweight = 1000/((intellect/100)/1.05)
  basecrit = 0.05
  critweight = 1000*(critpun/critrating/(((((crit/critrating)/100+basecrit)*critpun)+1)))
  masteryweight = 1000*(1/masteryrating/((1+(mastery/masteryrating)/100)+0.12)*baseatonment)
  versweight = 1000*(1/versrating/(  1+(vers/versrating)/100))
  hasteweight = math.max(critweight,masteryweight,versweight)  * 1.1
  leechweight = 1000/300*0.75
  normint = round(intweight/intweight,2)
  normhaste = round(hasteweight/intweight,2)
  normcrit = round(critweight/intweight,2)
  normmastery = round(masteryweight/intweight,2)
  normvers = round(versweight/intweight,2)
  normleech = round(leechweight/intweight,2)
  PawnUIImportScaleCallback("( Pawn: v1: \"Disc\": Intellect=" .. normint .. ", Versatility=" .. normvers .. ", HasteRating=" .. normhaste .. ", MasteryRating=" .. normmastery .. ", CritRating=" .. normcrit .. ", Leech=" .. normleech .. " )")
end

local frame = CreateFrame("FRAME", "UpdatePawn");

frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
local function eventHandler(self, event, ...)
 SlashCmdList.DISCPAWN();
end

frame:SetScript("OnEvent", eventHandler);
--[[
def getdiscstats(self,intellect,crit,haste,mastery,vers,blef=0):
       hasterating = 325
       critrating = 350
       masteryrating = 233.3333
       versrating = 400
       critpun = 1 #punishment for crit for being unreliable
       baseatonment = 0.75
       intellect = intellect + 1300  #flask

       intweight = 1000/((intellect/100)/1.05)
       basecrit = 0.05+(0,0.01)[blef]
       critweight = 1000*(critpun/critrating/(((((crit/critrating)/100+basecrit)*critpun)+1)))
       masteryweight = 1000*(1/masteryrating/((1+(mastery/masteryrating)/100)+0.12)*baseatonment)
       versweight = 1000*(1/versrating/(  1+(vers/versrating)/100))
       hasteweight = max(critweight,masteryweight,versweight)  * 1.1
       leechweight = 1000/300*0.75
       normint = str(round(intweight/intweight,2))
       normhaste = str(round(hasteweight/intweight,2))
       normcrit = str(round(critweight/intweight,2))
       normmastery = str(round(masteryweight/intweight,2))
       normvers = str(round(versweight/intweight,2))
       normleech = str(round(leechweight/intweight,2))
       #return "```( Pawn: v1: \"Disc raid\": Intellect =",normint,", Versatility =",normvers,", HasteRating = 1.1, MasteryRating =",normmastery,", CritRating =",normcrit,", Leech =",normleech,")```"
       return '```( Pawn: v1: \"Disc raid\": Intellect=' + normint+', Versatility='+normvers+', HasteRating='+normhaste+', MasteryRating='+normmastery+', CritRating='+normcrit+', Leech='+normleech+')```'
--]]
