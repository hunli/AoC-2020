def parse_line(line)
  split_line = line.split(" (contains ")
  ingredients = split_line.first.split(' ')
  allergens = split_line.last.chop.split(", ")
  [ingredients, allergens]
end

def cleanup_allergens!(hash)
  determined_allergens = hash.select {|k, v| v.length == 1}
  determined_ingredients = determined_allergens.values.flatten

  hash.each do |allergen, ingredient_list|
    !determined_allergens.include?(allergen) &&
      ingredient_list.delete_if {|ingredient| determined_ingredients.include?(ingredient) }
  end
end

def get_determined_ingredients(hash)
  hash.select {|k, v| v.length == 1}.values.flatten
end

def work(input)
  hash = {}
  ingredient_counter = {}

  input.split("\n").each do |line|
    ingredients, allergens = parse_line(line)

    ingredients.each do |ingredient|
      ingredient_counter[ingredient] ||= 0
      ingredient_counter[ingredient] += 1
    end

    allergens.each do |allergen|
      if hash[allergen].nil?
        hash[allergen] = ingredients.clone
      elsif hash[allergen].empty?
        raise "Unknown cause of allergen"
      else
        hash[allergen].delete_if {|ingredient| !ingredients.include?(ingredient)}
      end
    end

    cleanup_allergens!(hash)
  end

  cleanup_allergens!(hash)

  [hash, ingredient_counter]
end

def part1(input)
  allergen_hash, ingredient_counter = work(input)
  determined_ingredients = get_determined_ingredients(allergen_hash)
  ingredient_counter.delete_if {|k, v| determined_ingredients.include?(k) }
  ingredient_counter.values.sum
end

def part2(input)
  allergen_hash, ingredient_counter = work(input)
  allergen_hash.keys.sort.map {|allergen| allergen_hash[allergen] }.flatten.join(",")
end

input = "rdtsmnf xqs nzthdh txhvv sllchtz jjd jghpp zgds mffvp knxgb bphh jzhq vzptf ldvdfx pjcjh xcdlz zfmblk qjmlf qsgkrt jlfqx kml fmk fmgtn sfq bkcspp mrfb krp rrpcm ttgjfc qqnjk vcrmpm cpbzbx cxk hjfpql bdvmx rbfmr ltjmzc ghtmm ghvnf vxndk ffdg fbbk qvtbzg vbjr lzlj rtvrr lmzg cxrxk lxcrcmg dqnqhq ffmljg ffqclnjs fcqrhrd fgmffbx sqnqtk mhzhnc xmdhh hkhfzh lnxsk gqftg zxcvbd hmkpl bsqh ggvg drbm cfnt (contains shellfish, soy)
ffmljg spzg dgdhz cpbzbx fqvj cfnt bsqh zxgk dsqfxk vbjr cxk dlrfs jzvjs jlfqx kjgd pqxbk rkkl gqc shv qshj dsmh jmn zfmblk rjvlcd sbjmm tjggg kqprv gchbjgq sqnqtk hblxhmq rkvfhb vlv nzthdh mhzhnc sstd pnrl zfz mljkr lmzg zhf rncs hddd bsxh mzppft rdtsmnf xcdlz kptp mgnrx ldvdfx ckkfzg dqpt kzqc sqvp rkktt mrfb jrhcc hfqs jjd zgds fmk fmgtn btgrcc lhqzz lgkvtj sfq qsgkrt qvtbzg sbh ltjmzc hsblvlc drbm lqbxx (contains nuts, sesame, wheat)
drbm gqftg rbfmr fgmffbx mknkfs dpflnrn kml hddd dsqfxk dlrfs rspgrr rstl kdh kftq xcdlz lmzg ggvg hfmd qsgkrt hdhxjh dbggls cbrfxk hblxhmq cpbzbx bsxh ttgjfc vlv lxcrcmg shv krp kdbzgg mkjddl qbnjm gldb bcjk xlgpz dsmh dqnqhq bkcspp jzhq jlfqx kjgd zghxt sbh vxbqcfsg mzppft ffdg zbpz sjjttt ftdzvr ffqclnjs bphh fmgtn jzhrmj lmbvfh fcqrhrd jrhcc txhvv lnxsk tsdcshh pxjck qqdjm cxk jzhdd qkmjc mhzhnc zhf mljkr vxndk dvsch rkqpg ltktv kqprv bdvmx mrfb nhzms sqvp gvmgffd jzvjs cfnt sgdxgff (contains fish)
vtfgll rdtsmnf cbrfxk hgjfv qqnjk bsqh xmdhh kqsjnx pnrl kptp xcdlz hblxhmq kzqc rkktt kjgd dsqfxk ldvdfx gldb jjd sjjttt rbfmr rjvlcd mrcvzn hfpxtr drbm rkvfhb qshj hmkpl dhcrgj ffqclnjs qqdjm rkkl zxgk zhf lmzg bhbcn ghtmm vcrmpm pgbqnmn cfnt ltjmzc kqprv lzlj qqpn zhbh cqczhr jhflk cpbzbx cxk bsxh ttgjfc (contains sesame)
zgds hjfpql lmbvfh hgjfv bhbcn ggvg bsxh vdzdjv sgdxgff ckkfzg mljkr xmdhh gchbjgq rjvlcd nhzms lgkvtj jjd mrfb dqpt lrzhhn lnxsk cpbzbx cxk ldvdfx bzp hfpxtr jzvjs zxcvbd qjmlf mffvp fqvj rstl qqnjk jzhrmj gndpfff gqftg ccd hsblvlc sjjttt hfqs cvhb zhf kjfmz hblxhmq ppvtk ttgjfc qkmjc drbm jrhcc vcrmpm bdvmx cfnt btgrcc dlrfs bsqh shv lqbxx kqprv (contains peanuts)
qxl hfmd gvmgffd dqnqhq ckvfplbk jqrc lqbxx vzptf ccfsjrdb cvhb xqs mhgjhbj lrzhhn xxdtnv drbm lgkvtj mgnrx rbfmr jrhcc rncs hmkpl dbggls dpflnrn zxgk hblxhmq qqdjm hgjfv plhbnlk sqnqtk cqczhr qqnjk lmzg dsmh zfz pxp cfnt vpbpz xcdlz fbbk fqvj dqpt zfmblk ckkfzg rkkl zghxt ttgjfc ldvdfx kqprv kftq rspgrr lhqzz zhf gqftg bdvmx xlgpz jlfqx lnxsk fgmffbx qjmlf jmn ftdzvr ghmjv zgds rdtsmnf cxk fsqc cpbzbx vtfgll jzhrmj zhbh (contains soy, peanuts, shellfish)
bsqh kqprv vcrmpm zbpz lmzg rjpcxn vxbqcfsg tjggg hgjfv hfqs jhflk hblxhmq mtptg hdhxjh rjvlcd znskhl dqpt rdf ccj cfnt qvtbzg jmn zhf kqsjnx sfq qqnjk dgdhz vpbpz qkmjc sgdxgff cqczhr hbcvv hsblvlc zghxt lzlj sbh xmdhh jzhrmj qjmlf cvhb kdbzgg ffqclnjs bdvmx vdzdjv cbrfxk kzqc dhcrgj sllchtz qsgkrt xcdlz kftq lrzhhn dqnqhq jzhdd hvzpft cpbzbx rrpcm lxcrcmg drbm knxgb rtvrr ttgjfc ffdg zxgk zhbh (contains nuts, shellfish, peanuts)
cxk drbm ghvnf dsqfxk rstl ckkfzg xmdhh lxcrcmg bkcspp hkhfzh zbpz lmzg nzthdh jjd spzg vlv ccj pqxbk vcrmpm gvmgffd vbjr kptp ffmljg sbjmm jqrc dvsch vdzdjv ccd qqdjm ffdg xxdtnv rjzmst hjfpql fqvj sbh bsxh mffvp cpbzbx mrcvzn rtvrr txhvv zfz vxndk cfnt bhbcn jzhrmj srtvb jrhcc vtfgll zghxt zhf qjmlf rkqpg fbbk ttgjfc bdvmx lrzhhn fgmffbx shv gqc jghpp bsqh btgrcc zfmblk mgnrx mljkr fsqc rdxzmmjp hgjfv cqczhr (contains dairy)
cpbzbx lmzg dbggls kjfmz mtptg sbh zbpz sgdxgff zghxt bphh krp vtfgll rspgrr rkktt vxbqcfsg lqbxx ffdg pnrl zfmblk ffqclnjs znskhl drbm qkmjc kqprv bzp ccfsjrdb gndpfff ftdzvr btgrcc kptp jzhdd cvhb hddd rdf bcjk lxcrcmg cbrfxk jdbs mmtnx zxgk sllchtz dqpt kml rstl jrhcc knxgb fsqc lnxsk bsqh kqsjnx rjpcxn pxjck vzhpx nzthdh jghpp ffmljg ltjmzc cfnt rdxzmmjp pqxbk bdvmx vdzdjv mrfb (contains dairy)
xmdhh zbpz ccd kdh cxk fsqc ppvtk ggvg kjfmz ltktv pxp mzppft ffdg fgmffbx vcrmpm btgrcc mkjddl bphh bcjk vxbqcfsg ldvdfx rjpcxn hddd zfz tsdcshh bsqh zhf rkvfhb sstd lmzg cpbzbx vzhpx pgbqnmn knxgb pxjck gndpfff qsgkrt cfnt gchbjgq nhzms sblqr jhflk lgkvtj mknkfs xlgpz sbh jdbs hmkpl xxvbfs rkkl hsblvlc kqprv hvzpft dbggls mgnrx rrpcm hbcvv pqxbk jzhdd dsqfxk sbjmm fbbk fmgtn kjgd bdvmx pjcjh cqczhr ckkfzg vlv jxkdmk ckvfplbk rbfmr ccj (contains nuts)
mffvp rbfmr chsf lqbxx hfmd dhcrgj qqdjm fbbk vzptf hmkpl cbrfxk mhzhnc cxk bsqh xlgpz cpfftt gchbjgq gqftg tjggg lmzg lgkvtj pxjck zxgk vcrmpm vxbqcfsg jqrc vpbpz rjzmst dgdhz fmk rkkl rdxzmmjp mrfb cfnt qqpn sbjmm rkvfhb mljkr jmn gndpfff mtptg drbm dpflnrn kqprv qjmlf lrzhhn qsgkrt nzthdh xmdhh jzvjs fcqrhrd fgmffbx dbggls jxkdmk pgbqnmn kdbzgg kml zfz rjvlcd mknkfs rdf cpbzbx (contains sesame)
mkjddl vdzdjv dpflnrn vxndk bphh rjzmst qxl ltjmzc cxrxk gqc gldb mmtnx ccd hfqs jxkdmk hvzpft zxcvbd gqftg mrfb pxjck sgdxgff kqsjnx cpbzbx rncs fmk mffvp hbcvv cfnt ckkfzg cbrfxk mhgjhbj kqprv rrpcm tnt srtvb cxk vlv xlgpz lmzg gndpfff ftdzvr dqnqhq sfq rtvrr fbbk ccfsjrdb zxgk kzqc vpbpz cqczhr mhzhnc pjcjh bhbcn bdvmx kjgd rstl bsqh ctqtgjb rkqpg jlfqx vzptf knxgb sqvp sjjttt fgmffbx (contains soy, fish, nuts)
lxcrcmg qshj zhbh vxbqcfsg cfnt pjcjh bdvmx jmn fsqc dvsch sbjmm txm tjggg ghtmm mrcvzn rjzmst mhgjhbj kptp hgjfv mffvp bsqh cvhb mtptg ftdzvr kftq lgkvtj mknkfs sjjttt kqsjnx rdf rjvlcd qqdjm pxjck hfqs ccj jzhdd bsxh cxk mgnrx lzlj rrpcm mljkr qbnjm cbrfxk cpbzbx lmzg cpfftt kqprv rstl mhzhnc zfz qvtbzg (contains peanuts, sesame)
zghxt rncs gchbjgq fgmffbx bdvmx hfpxtr cqczhr qvtbzg srtvb cxrxk bphh lmbvfh lzlj hgjfv xlgpz gldb dqnqhq jzvjs cbrfxk qqnjk sllchtz mhzhnc pnrl gvmgffd ldvdfx txhvv cxk sblqr drbm mtptg jmn rstl pxp fqvj zxcvbd ghvnf rkkl zxgk jqrc tsdcshh kqprv zfz kjfmz vtfgll lnxsk ggvg rkvfhb cfnt dgdhz ckkfzg btgrcc kptp jhflk lmzg knxgb xxvbfs mhgjhbj pxjck bsqh ghmjv qqpn (contains dairy, peanuts, shellfish)
cpbzbx jzhrmj hfmd cxk fsqc rbfmr vbjr qqdjm vzptf dsqfxk plhbnlk rjpcxn vtfgll btgrcc knxgb zxgk txhvv pqxbk sqvp ghmjv ggvg kml bsqh spzg ldvdfx vxndk fbbk drbm dhcrgj mgnrx kqprv bzp mljkr rdxzmmjp pxp zghxt jjd bcjk srtvb ltktv vxbqcfsg kdh mhgjhbj jzhdd hmkpl ccd pxjck xmdhh cvhb ppvtk mffvp shv lnxsk zfz sblqr bdvmx sstd hvzpft cfnt (contains shellfish)
cxrxk tsdcshh rtvrr mrcvzn mkjddl fbbk plhbnlk qkmjc ghtmm txhvv jhflk lrzhhn sqnqtk cpfftt jxkdmk ghvnf kdh cfnt jghpp bhbcn bsqh sgdxgff srtvb ffqclnjs sbh lmzg ltjmzc dqpt bsxh hmkpl ghmjv kzqc pqxbk jzhrmj zhf pxjck rkqpg lxcrcmg mhzhnc cbrfxk xqs kml zghxt pnrl mrfb qvtbzg fqvj vlv hddd sbjmm bdvmx vbjr sblqr qjmlf dlrfs lnxsk kqprv cxk ggvg dhcrgj hvzpft lzlj drbm xcdlz (contains peanuts, wheat, nuts)
rjzmst zghxt rtvrr bsxh znskhl cbrfxk hbcvv mzppft fcqrhrd jhflk ccj ppvtk bsqh fsqc vdzdjv drbm plhbnlk lmzg hjfpql jjd ffqclnjs jqrc ctqtgjb dbggls qjmlf zfz ftdzvr sbh mknkfs qvtbzg gqftg cfnt fmgtn cpbzbx dvsch mgnrx kqprv rrpcm rstl mhzhnc srtvb hvzpft shv dlrfs sstd mjtz hmkpl jzvjs qkmjc kftq fbbk lmbvfh tjggg vzhpx hsblvlc jghpp bdvmx zxgk qbnjm (contains wheat)
jxkdmk zgds pnrl mrcvzn qjmlf bphh ghvnf srtvb zhf kzqc jzhq drbm sblqr rkvfhb knxgb rtvrr bdvmx gqc dsmh qkmjc zxgk mhgjhbj mgnrx rspgrr cpbzbx mkjddl lmzg cxrxk mknkfs fcqrhrd sqnqtk xcdlz rncs vtfgll sgdxgff jmn bsxh txhvv sjjttt ghmjv bsqh jzvjs rjzmst xxdtnv rbfmr sfq sqvp vpbpz dpflnrn cfnt hgjfv cvhb lhqzz hfqs rkkl qshj dqpt jghpp dlrfs zhbh cxk zfmblk xlgpz ghtmm ppvtk rjvlcd ccj hfmd txm fsqc qqnjk dhcrgj ldvdfx jdbs jrhcc mzppft sstd pxp xqs (contains soy, shellfish, peanuts)
kqprv drbm lzlj mtptg mljkr fgmffbx qshj txhvv rbfmr lmzg jzhrmj sqnqtk cpbzbx lrzhhn mkjddl srtvb bdvmx cqczhr kml gchbjgq fsqc rjzmst vxbqcfsg gvmgffd kdbzgg hmkpl rdxzmmjp cxrxk lnxsk mzppft ghmjv kzqc zhf bhbcn cxk bsqh ffqclnjs vbjr fbbk txm xxvbfs mrcvzn (contains sesame, peanuts)
sblqr gqftg dlrfs lnxsk vbjr ccfsjrdb mljkr vlv qsgkrt fbbk pxp mmtnx fqvj sjjttt zfz hkhfzh vzptf cpbzbx gldb kqsjnx txm kqprv dsmh qqdjm rjzmst ctqtgjb hgjfv mtptg xxdtnv qbnjm ghtmm fcqrhrd gvmgffd xxvbfs jmn fmk srtvb mzppft zbpz sqnqtk bdvmx tsdcshh rdf dqnqhq lmzg cxk tjggg xmdhh xlgpz hfpxtr sqvp pxjck rkvfhb mffvp bzp qkmjc jjd gndpfff ttgjfc lrzhhn btgrcc hjfpql bphh sgdxgff ccd hfqs rrpcm txhvv rdxzmmjp bsqh jdbs lgkvtj cfnt (contains soy, fish, peanuts)
dlrfs pnrl hddd kml sqvp sfq dbggls rkqpg ckvfplbk vdzdjv gqftg hfqs lrzhhn jrhcc qsgkrt mgnrx cxk sgdxgff rjvlcd qjmlf sbjmm lmzg cbrfxk bsqh tnt rkvfhb mrcvzn hmkpl zgds bsxh qqnjk vxbqcfsg pxp xcdlz gldb ffdg rbfmr ghtmm hjfpql zxcvbd lqbxx kdh bzp hgjfv kjfmz zghxt pjcjh jjd rkkl kqprv ffqclnjs qqdjm cpbzbx jdbs nhzms vzptf drbm qqpn dhcrgj rrpcm btgrcc qxl chsf ftdzvr ltjmzc jxkdmk hkhfzh bdvmx gqc tjggg vlv sblqr vcrmpm znskhl rjzmst ghvnf jghpp txhvv (contains peanuts, fish)
ggvg txhvv xqs ppvtk kdbzgg dsmh qqnjk rkvfhb fqvj drbm cpbzbx kjfmz bsxh cfnt ldvdfx qqpn fbbk kqsjnx jmn dqnqhq mrcvzn dsqfxk tjggg mhgjhbj pqxbk krp bhbcn ctqtgjb kftq zbpz hkhfzh zfz zhf gldb fsqc mffvp hmkpl rdtsmnf btgrcc cxk hdhxjh bkcspp rkkl dhcrgj lmzg sblqr vzhpx rrpcm zhbh jlfqx bdvmx lmbvfh kzqc ckkfzg kjgd srtvb fgmffbx dvsch ccfsjrdb pxp rdf qqdjm spzg rspgrr hjfpql fmgtn ftdzvr mmtnx hfqs lqbxx mhzhnc mzppft pnrl qsgkrt hsblvlc ghmjv sqvp sqnqtk tnt kqprv vdzdjv zfmblk (contains sesame, peanuts)
bphh cxk vxndk hddd ltjmzc jzhdd rdf jlfqx kml vbjr ffmljg lmzg mjtz bkcspp rdtsmnf dhcrgj vxbqcfsg spzg ldvdfx nhzms kdbzgg hmkpl ftdzvr cbrfxk gvmgffd xxdtnv zfz drbm ffqclnjs sjjttt dvsch mhzhnc jzhrmj dlrfs vlv fmgtn gldb ckvfplbk kqprv qxl rjpcxn qbnjm hfmd ttgjfc zfmblk kdh bsqh gndpfff tjggg mkjddl bhbcn dsqfxk rjvlcd sqvp fgmffbx bdvmx rspgrr bsxh vzptf kjfmz jghpp dgdhz hgjfv gqftg fbbk jrhcc cfnt (contains fish, dairy, soy)
zghxt fmgtn ckkfzg shv hbcvv zbpz spzg cpbzbx hdhxjh gqc dbggls sstd zxcvbd bzp ctqtgjb dqpt xlgpz mknkfs pgbqnmn mljkr gqftg tjggg bhbcn jzhq jxkdmk jlfqx qkmjc kqsjnx ghtmm ckvfplbk kjfmz lhqzz pqxbk sblqr fsqc fqvj vzptf xcdlz pjcjh ffqclnjs zfz rbfmr rjvlcd dpflnrn drbm cxk ttgjfc jrhcc dqnqhq chsf kqprv ghmjv rdf hsblvlc krp plhbnlk cfnt fmk jdbs gldb mhzhnc lxcrcmg lnxsk kml xmdhh hgjfv vzhpx rtvrr zxgk bkcspp mrfb ccfsjrdb sgdxgff hblxhmq lmzg bdvmx lgkvtj lzlj jqrc pnrl txm (contains shellfish, soy, wheat)
drbm kjfmz rkktt rtvrr rstl hfqs lzlj nhzms mhzhnc qsgkrt hsblvlc rjvlcd kml sgdxgff bsxh hjfpql sfq cpbzbx hddd gqftg lhqzz lmzg cxk tnt sblqr dbggls gchbjgq ltktv dqpt chsf dlrfs hfpxtr zbpz vxndk zhbh dhcrgj jjd mtptg kqsjnx mknkfs ghmjv cvhb srtvb xmdhh hvzpft bsqh ltjmzc vdzdjv lrzhhn hdhxjh nzthdh kzqc zfmblk pjcjh pxjck sllchtz cqczhr hfmd rdtsmnf pgbqnmn bdvmx hkhfzh mljkr jghpp fsqc qqpn kqprv ffmljg (contains dairy)
ttgjfc rjvlcd kjgd jzvjs qqnjk hkhfzh sfq cbrfxk sqvp gchbjgq zhf kml kqprv jrhcc cqczhr znskhl ccfsjrdb cvhb ctqtgjb lmzg bdvmx krp qjmlf tsdcshh gldb mzppft shv hsblvlc rspgrr mhgjhbj dqnqhq drbm gndpfff jqrc hdhxjh mkjddl chsf dgdhz hbcvv qqpn mknkfs bsqh zbpz cfnt lzlj dsqfxk fmgtn rdxzmmjp hblxhmq hddd sqnqtk rrpcm ffdg kqsjnx kjfmz xmdhh jjd qxl pnrl dsmh cpbzbx dlrfs ghvnf sbjmm hgjfv jxkdmk xqs kzqc ltktv ggvg jghpp ffqclnjs bkcspp (contains sesame, soy)
bsqh ckvfplbk ctqtgjb kqprv rtvrr rjpcxn pjcjh drbm bhbcn kjfmz vpbpz mhgjhbj mgnrx cxk zhf kzqc sqnqtk sfq txm rkktt dbggls hgjfv xxvbfs ftdzvr ggvg pnrl lmzg ltjmzc bdvmx dqnqhq sstd rdxzmmjp cqczhr gchbjgq ckkfzg zghxt fbbk cpbzbx kftq znskhl fcqrhrd vxndk jghpp zfmblk rrpcm ltktv ffmljg (contains peanuts, shellfish, sesame)
pjcjh ccj hdhxjh rdf bsqh lmbvfh zhbh qjmlf mjtz rncs kftq dsqfxk ghmjv rjvlcd znskhl btgrcc plhbnlk vpbpz cfnt jzhrmj bdvmx hddd zhf krp dlrfs xxdtnv sbjmm fgmffbx lmzg cxk dpflnrn drbm pxjck gqftg gndpfff mffvp bkcspp ttgjfc tsdcshh bphh cpbzbx rkktt jmn qvtbzg mmtnx kqsjnx sbh rjpcxn gchbjgq cqczhr mhzhnc zghxt mhgjhbj hmkpl cbrfxk mzppft qbnjm zgds hfqs fbbk cxrxk vtfgll (contains peanuts)
rjpcxn hsblvlc hgjfv vzhpx dvsch dsqfxk txhvv zbpz jhflk vxbqcfsg mjtz qshj pqxbk lnxsk cfnt cpbzbx rdf hmkpl dbggls jmn jzhdd fbbk lqbxx sqnqtk fmgtn plhbnlk kftq cxk bzp ckkfzg ghvnf vbjr sblqr ltjmzc vzptf qvtbzg rrpcm hddd bsqh bkcspp ghtmm vpbpz qxl rstl hfmd qjmlf knxgb mrfb qqpn dsmh rtvrr mljkr lmzg lrzhhn zhf sllchtz pnrl mtptg gqftg hdhxjh zfz kqprv zghxt drbm hblxhmq dqnqhq btgrcc mzppft bphh hvzpft mhzhnc kdbzgg ffmljg txm sbh tnt xxvbfs (contains nuts)
shv rtvrr chsf vpbpz jqrc rkvfhb mmtnx jjd sjjttt drbm lmbvfh cxk ghtmm xqs sfq mrcvzn bsqh ffdg mkjddl zghxt cfnt mffvp kdbzgg cpbzbx rncs bzp sllchtz mhgjhbj bdvmx hddd vbjr jmn jzvjs rdf hsblvlc pxjck pnrl kqprv vxndk rrpcm qvtbzg mljkr fmk qjmlf ccfsjrdb rjvlcd lrzhhn bphh cqczhr hfqs dbggls nzthdh kftq ckkfzg fcqrhrd (contains nuts)
vcrmpm bsxh kptp jqrc jzvjs lmzg xlgpz ctqtgjb hmkpl cpbzbx bcjk bdvmx qbnjm rjzmst cpfftt zgds kqprv jdbs bsqh gldb cfnt vpbpz sqnqtk dsqfxk ltjmzc rdxzmmjp mjtz hvzpft ggvg mrcvzn xqs vtfgll fbbk sstd vdzdjv cxk lhqzz dsmh dgdhz sgdxgff jzhq sbjmm bphh qvtbzg sfq jhflk (contains nuts, fish)
vzptf mtptg ccj mhzhnc ghmjv knxgb ggvg dsmh txhvv lmzg fmk sjjttt vcrmpm mffvp kftq fcqrhrd qqdjm bsqh kdbzgg bsxh kml bdvmx hfmd tsdcshh jzhrmj bkcspp vxbqcfsg mjtz vdzdjv kqprv qvtbzg sstd nhzms qxl znskhl hddd zhbh rdxzmmjp qkmjc zxcvbd cpbzbx jqrc pxjck pxp kptp jmn xlgpz dlrfs vpbpz hsblvlc spzg ffmljg ckkfzg sfq rrpcm tnt mljkr jhflk sqvp hblxhmq ltjmzc cfnt drbm vlv (contains shellfish, peanuts, nuts)
gldb ffmljg ftdzvr sllchtz lmzg hkhfzh zxcvbd tsdcshh kqprv krp fmk rkqpg mrfb fmgtn zhf mzppft tnt dbggls jzhq bzp vzhpx hvzpft cqczhr znskhl qxl ttgjfc bcjk hsblvlc bdvmx mrcvzn xmdhh zhbh dhcrgj cxk rjvlcd ghmjv vxndk qqnjk cpbzbx mknkfs jzhdd xcdlz qkmjc fsqc hddd hdhxjh nhzms vxbqcfsg qqdjm gchbjgq nzthdh ccd mgnrx jlfqx mjtz hblxhmq dqpt tjggg fcqrhrd fgmffbx rbfmr drbm jghpp cfnt kftq mkjddl (contains fish, soy)
cxk cfnt ghvnf zghxt fsqc mrfb bdvmx shv ctqtgjb ldvdfx lgkvtj mffvp mhgjhbj fmk dgdhz cqczhr vzptf qjmlf lrzhhn dqnqhq bsqh ffqclnjs ggvg tjggg sgdxgff zfmblk zhbh bhbcn jghpp cpbzbx ltktv hmkpl jdbs jzhq sqvp dqpt bcjk dvsch xqs lnxsk cvhb zgds jmn zfz vcrmpm qqdjm drbm mzppft vbjr kml dsmh ltjmzc vzhpx qkmjc mmtnx dhcrgj bsxh ftdzvr lhqzz rjzmst qxl sjjttt mrcvzn qvtbzg pnrl hgjfv znskhl gvmgffd ckvfplbk jlfqx pxjck vxbqcfsg pgbqnmn rtvrr plhbnlk gndpfff kqprv pqxbk (contains fish, nuts, wheat)
krp lmbvfh kftq fsqc rjpcxn sqvp cfnt mkjddl zghxt fcqrhrd hfmd dbggls hblxhmq rncs ccfsjrdb rdtsmnf rdf sstd ffmljg lqbxx jzhrmj mjtz gldb hgjfv bsqh kqprv txhvv dgdhz bdvmx gvmgffd jzhq zbpz jlfqx cpbzbx sbjmm cxk ccj cbrfxk gchbjgq qjmlf mffvp bphh jghpp gndpfff hfpxtr ccd kml ltktv drbm vlv sllchtz kdbzgg fbbk pxjck sfq kzqc hddd jzvjs fmgtn ckkfzg hbcvv bkcspp dqpt hsblvlc hdhxjh ltjmzc ftdzvr vpbpz pxp vdzdjv pjcjh (contains sesame)
qjmlf zxgk ckvfplbk gqftg zfz fbbk cxrxk zghxt dbggls lzlj vdzdjv rkkl vzhpx bsqh kqprv dqnqhq ghvnf zfmblk vxndk lqbxx cxk sqvp qqnjk rdxzmmjp ftdzvr jlfqx dpflnrn jzhrmj txm jxkdmk kjfmz dsmh vlv znskhl kdbzgg hblxhmq lnxsk qshj ccfsjrdb cpbzbx btgrcc ccd cqczhr qqdjm dgdhz hgjfv drbm bdvmx txhvv lgkvtj cfnt ghtmm rjvlcd (contains soy)
qbnjm ghvnf gchbjgq zfz cbrfxk bsqh rdxzmmjp vxndk krp rrpcm ckvfplbk fmk bdvmx bhbcn ccd lmzg mffvp sstd hfpxtr sqvp hkhfzh qxl dbggls jhflk sbh znskhl ggvg lnxsk sblqr kml jzhq jzhrmj ltktv lmbvfh spzg cpbzbx jdbs zhbh kqprv drbm lgkvtj zhf txm rspgrr sbjmm vbjr ghtmm tnt fmgtn cxk bphh dpflnrn lhqzz rdtsmnf kqsjnx gndpfff knxgb hfqs gldb pxp xlgpz vpbpz qjmlf ffmljg zbpz cxrxk kjfmz rstl (contains fish)"

dummy_input = "mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)"

p "Part 1: #{part1(input)}"
p "Part 2: #{part2(input)}"
