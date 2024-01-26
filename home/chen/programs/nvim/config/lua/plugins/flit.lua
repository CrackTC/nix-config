return {
    "ggandor/flit.nvim",
    dependencies = { "ggandor/leap.nvim" },
    config = function()
        require("flit").setup({
            keys = { f = "t", F = "T", t = "g", T = "G" },
            labeled_modes = "nvo",
            multiline = false,
            opts = {
                equivalence_classes = {
                    '.。', ',，', '?？', ':：', ';；',
                    'a哀矮癌澳瑷案岸廒暧氨遨嗳璈鏖啊碍骜盦毐皑翱嗄爱鳌蔼𩽾媪暗嗌盎岙按谙桉犴卬螯凹埯铵砹腌隘唉鹌傲鏊聱阿埃锿昂熬黯安胺袄吖叆隩嗷嫒庵垵拗锕敖挨獒哎唵奡奥懊坳鞍欸肮艾霭俺',
                    'b坒鞴驳拜粑妣疤惫佰哺糒扮瘢礴砵坋拔般呗缤便玢褒爸毙扳板抃鲍扁榜袯庇佖捕叭鲅畀绊丙并邠钚豹弁萹边鐾馞髌塝龅笔八婊钯蔀苄脖抱诐笆吧裱碑傍稗箅棒鹎碥保宝秘伴梆被湴兵瀑藨瘪蛃栟愎倍必踣彪煸表褊髀嶓包倴犇冰不畚镖膑邲朳编葆薜胞鲾饽半簿弊鬓靽僰爆昺飙变帛𬷕晡舶濞避琫趵摈泵磅蹩报鳖遍嬖巴璧膀瀌苞吡濒背啵北饱捌俾菠拨搒剥箔骠镚蚆蓓卞胈膊泊备鹁彼荸贬坌憋崩膘忭贝篦迸钣铂别飑鼻白泌筚汴逼邦跋鲌逋跛桲刨妭屏颁败罢蔽镳脿绑裨布埠班豳贲镈滨甏坝比斌碧匾陛暴鸨𬭛帮笨把波悲靶褓癍辫禀勃薄棓鄙秕亳摆擘殡堡蒡闭俵哱宾辨耙昪祊鞭秉斑搏杓币狴儦曝柏哔苯钵匕瘭孢婢渤蚌昄辟蝙钡病甭庳炮鳊霸簸傧枹狈饼谤锛煲镑瓣捭补醭菝标卟阪步浜摽毕砭珌玤版怖播痹彬部鲃陂嘣扒觱百办摒柄壁魃赑臂滗羓柈弼岜蔈博檗掰拌蓖芭伯卑蕃卜敝辈辩奔毖灞搬碚鳔槟邴雹炳𠳐椑熛蹦钹铋镔坂焙本绷玻杯埔悖',
                    'c崔撮脆黪曹措残彩骖佽榱苍瘥匆掺矬缞淬粹撺裁栅璨粗聪槽恻参泚萃瓷摧篡酢辞糍蹿骢嶒悴蹭擦镩睬痤熜磁惨册嵯嚓草财瘁徂菜璀啐茈醋噌搓粲蔡涔囱枞衰蹙皴蹉琮艚跐次璁簇赐材𥕢测挫莿促莝漼苁刺茨厝鸧沧窜忖鹾殂餐凑伧𫚖嘈存惭瑳攒卒邨疵蚕此慈爨蹴螬汆灿糙藏伺寸舱翠葱猝村腠辏酂侧丛才曾猜呲策漕踩厕玼脞操仓锉采岑淙从悰蔟雌词差祠错催层鹚磋孱',
                    'd侗窎当迭遁垛点丁迨蚪盗陡蹈堞芏笃驮第单跺篼岽嫡蹲耵椴旦戥涤骶多炟煅亶都督棣狄诞地𬍡淀哆谠东嘀殚导掇端酊搭滇瞪爹炖舠鸟扽咄叠递刁短惇铫坫耑耽敌哒垱怠妲郸踮嘚磴缎柢赕谍垌跶凋埵囤渡髑队趸抖楯的柁凼达锝黛踶杕诋聃道掉店铥段打疔垯铛定䗖胆傣毒提帱踱疍渎捯懂啖癫剁坻鱽啶弟碇窦椟斗歹躲栋𫟼氐鲷钝对咚哚貂眈叇邓顶靼塅灯鞑娣袋顿底甸档吨惮鸫荡瘅耷阽但玎镝朵珰钿儋到宕亸𬭚呆𫶇冻玳腚牍独迪砥佃带峒镦锭仃硐钓垫岱髢墩沓蹬戴扂荙黩蹢呔叼璒堆氮等帝胨洞剟瘩党瑖𤧛氘蛋犊琔冬嶝叨膻籴大瓞厾疸兜邸赌掂典夺耋痘度缔䃅董㙍盯贷萏待蹀忉埭癜镫睇嗲登兑鞮楪纛钉𬘘簖祋喋肚怼觌舵弹碘惦读担蒂胴碲动悼调绖萣碉抵逗殆捣鲽堤挡吊焘杜掸垈岛碟豆镀噔裰惰电笪稻谛憺澄轪沌盹蠹钭町𬟽礅荻蝶翟碓德石巅靛代恫砀铤跌睹订堵丹砘玷答凳叮垤锻嗒昳裆刀𣗋蔸滴铞堕奠逮鼎妒颠笛丢簟牒菂雕媂䏲低祷得铎嘟倒淡褡殿菪氡怛𫢸盾敦绐断',
                    'e屙恩二呃儿娥垩鲕讹涐莪阿扼锇恶佴鄂苊鹤咡鸸饵鳄洱铒愕轭噩耏贰鹗而腭哦锷厄遏婀蒽颚峨蛾额俄鹅耳萼谔摁陑尔𫫇迩欸堨嗯珥饿阏',
                    'f啡舫副镄艴冯朏茀辐芬缶腐蝠扉翻莩翂郛房费缝番蚨鲋昉幅珐服簠凤玞饭附缚抚樊锋肺粪赋芾富坋垡俯悱鲼吩堼纷范返斐发敷趺绯负付愤玢榧蜂绋鄜蜉墦沨吠麸覆乏咐怫讣阜枋复脯鼢韨放纺崶剕霏法沣棼焚逢黻汾黼否菲烽彷幞奋苻跗贩洑㳇妇飞妃稃父酆狒诽非肪蘩肥斧桴翡繁峰拊宓浮腓奉帆蹯绂阀呒驸反牥犯畈俘讽棻呋坟罚泛烦腹孵蕃府风枫矾访仿涪佛辅孚砝邡妨痱凡扶分傅𫖯废福匪符𬴂赙丰酚蜚淝拂梵罘馥坊藩袱滏疯鲂氟甫粉俸芣防琈幡砆沸钒腑蝮芙伐伏瀵燔氛茯鲱豮璠赗钫忿唪榑釜菔葑方肤弗匐赴夫筏篚份棐芳封砜',
                    'g阁倌苷淦伽观觏溉枸擀膏塥牯宫匦呱骼钴鲧贯涡蒄桄扛疙虼棍更龟鿍拐姑诰格遘篝陔赣磙媾公郭革颌垙葛矼港咣规垢涫狗姤澉给功柑刚邽剐沟崮搁共冈钆埚刿贾割杲旰虢梏干妫鹒杠酐岗噶戈嗝胳竿嘎耿颈赓𬮿馆毌瑰皈锅炅旮够梗𬇹瓜馘蝈稿丐痼栝鞲疳荄雇堌橄广鸹工圭㭎羖冠硅佝诡寡高诖汞矜莞桧灌告尜巩晷罟戆谷槔玕绲刮购罡恭纶根琯归臌哏蚣乖鳡滆骨筶固夬柜鬼彀崞咯岣皋尴鸪槁藁篙胍鹘羔鲑觥怪腘绀肛𨐈胱庚勾合犷赶管歌矸鳤辜挂搞攻敢晐顾咖舸纲唝仡果茛𬒔酤哥帼隔苟羹泔肱掴秆糕闺哿轨刽蜾赅瞽垓珪鸽祼改衮镉聒感供鲠笱耇贡哽膈弓蛤菇鲴鳜缸毂坬股肝𦙶圪戤菰杆冮镐鬶鹳贵汩滚逛关过铬棺宄跪惯估钙褂尕国坩瀔堽构裹戛诟尬该光盥洸躬鼓沽珙筀个箍筻钩呙咕诂盖辊瓘庋蛊绠郜鳏艮轧粿氿鬲睾卦袼椁癸故埂桂锢拱硌甘簋纥各浭龚缟跟耕缑饹夹古亘掼孤罐概爟锆轱官钢',
                    'h囫幌衡郈湖换贿徽绗耠鹮蟥荭菡琥訇挥暵恒憾侯鄠鬟凰糊桦晃巷谎姮化后惠醢阍候馄遑海菏堠𬌗骅哄赫黄颌晗宦垕戽豪颃浣昏虎崡痪划竑诙嗐孩喝哼晦涵货旱亨唤吽护昊盉韩斛貆昒慧汗萑纮诲涣祸瓠𬭎嚄壕侴糇幻漶袆花隍骇氦壶恚恨鼾颢鞨嵅惚皓耗晖惶洄猢浒酣轷轰葫呼浑撖翰焕沆劾灏呵杭荷乎铧寒宏濩喙𬭶𬴃癀禾𫟹鹖厚𤩽恢橞玒攉悍嗬犴鄗忽郇鸻怀瀚鲎阂何缓恍函很蒿桧簧篁瑚诃隳混桁熇琀狐缳弘圜喤罕璜浩溷寰郝薨峘觟顸彟钬媓鲩辉貉蛔坏画悔汉讳豁唿卉滑横泓咴骺骸蝴毫㬊航毁煌痕撼醐吭慌获鹕𬘫洹鹘铪曷嗨荟桓绘合獾蘅蠖翯婳彗齁夯嬛华鸿涸憨蚝亥嚎汇扈澴沪喉郃槐焓魂瘊翮昈岵行蝗号欢垾会灰蟪霍婚惛烩祜蚶滹饸阚淮肓盒黉硊猴麾夥嘿隺奂鹤薅伙珩嫭龢𬭤弧哕嚯活珲和鹱逅豢蛤煳咳患哈荤还笏黑回湟户喊镐鳇锾茴虹怙盍胡胲红或淏劐害烘滉捍篌焊徊佸硔惑哗贺龁褐蕙潢虷鳠阖含互逭吼藿闳谼踝狠核鲘壑皇堕蕻邯秽火垎纥环诨濠邗蔊㸌鹄𬣳槲砉洪唬猾荒颔讧河好镬话吓㘎虺擐淴徨',
                    'i城褚庱漴躇觇瞅撑躔娼潮拆檫单驰舛舂愁忏馋痴楂谗衬臭除吹仇瞠眵铖媸汊镵橱蠢裳笞潺绰䢺锸虫俦丑鹑沉淳惙肠翅棰骣闯茶碴超锤臣谶椆畴陈础喘忱乘菖龊椎呈崇豉螭宬偿叱秤惆厂瀍䲠韂厨饬忡㳘捶耖孱趁疢俶种瘥掺铛怊搐摴帱扯畜褫巢诚谄床枨塍苌坻姹抄澶倕尘唱澂耻嚓喳珫瘛吵氚筹钏赪炊逴巉噇船傺啻㬚阐踟裎齿川唇尝插垞虿𬺓抻丞旵骋抽剿惝敞砗馇遄彻琛𬘭篪侪初茝创处哧窗碜场揣称𬭚蚩怆畅杈撤伥楚赤徜彳嗔镡牚常猹圌羼椽醇蛏盛黜雏踔晁缠迟瑃出匙弛长晨瘳疮弨炒胣昶尺埕钞斥𫄨辍憧炽刹梣柴琤侈憷酲辰豺矗重辿啜槎犨陲茺鬯绌纯䝙橙婵搋蝉程鲿儳吃嗤锄穿春晟岔蹅逞瞋蹰宸焯铲蟾阊鲳昌颤池镲酬坼蒇衩偁椿朝禅铳珹叉嘲查莼察憕储踌搽瓻侘串亍澄滁冁传成冲茬猖怵柷嫦戳宠佁杻杵幢槌充搀廛钗倡魑掣刍堾蝽啴伧绸敕车郴谌茌濋欻龀惩珵蜍澈触持诧垂稠踹产柽墀差摛承𬊤嵖',
                    'j橛且桀鄄伽郊局糨跤井计倞净拒斤靬嵴俱焗鼱棘砠睫玃䴗衿机进津饺嫉荩踽揭冏醵皎结禁挤境赳祲脊其崌𬶋爝降傕晶龟湝煎笺鲸䴔京惧辑讥狡姐脚迦矫锦诀楷瘕劲𫌀荆浸蠲倨泃蹐蛱畸浇蕨敬桷给龃檞截界犟矶监疚劂俊汫匠鹫简槚笳洚绩亟祭佼窭击架犍江济妓贾炬隽季砄酱歼巨佳侥迹教冀戬腈椒珒婧桕霁驾精镢疥颈嵇交瘠镓渐加镌旧堇讦炅噤鱾经甲跽姜叫蕺警鲚茎晙妗价弶菌襟靓抉劫鬏奖颊嘉鹣灸稼距君纠羯斝姬戋觖揪殣罽绞极踞拘峻憬獍屐迥剪奇噱犄肼赍竞鞯玖厥景廑泾拣睑岬近寄涓焦厩苣剑杰矜继徼馑晋笈汲藠槛技矩今记倦堲际裥婕讲枷恝鉴漈坰剿鳒践蚧间较礁借畯诫搛鲣咎窘拮基酒缄巾谨啾腱剂肩𬳶玦扃䴖娵雎镜桨颉戒葭决鞬就犋奸劼柜戢捐絜葰䌹艽醮鹃阱驹孓尽矍几粳迳建舅钜倔麇猄沮徛娟裾蒋浃𬬱秸尖戟锯缣峤骄锏鲪即胫缉㠇嗟畿圾箭掬荠韭稽鞫痉解珺纪惎鲫噍蛟僵瑾觐节钾柩湔紧贱浆僦𬶭麖桔鋆豇鲛睛锔娇莙俭芥铗九寂岨毽缙件仅疖臼静诘鸡狙袈轿暨鞠靳家炯箕悸𬯀皆烬鳉湫涧撅肌期璟钧吉翦居耩麂岠笄疾鲒蹶健飓救级竟缰菅减蹇疽桊茭角掘郡强荚军靖膙坚疆䐃胛虮𪟝窖秬刭将偈校捷焆蕉趼榉筋爵己届谫暕街卷掎绢骥咀孑饥羁骏谏柬集喈介泂觊嚼金笕捃𫓯皲眷见及斠阄琚据惊蒹墼獗绛假橘荐剧讵嫁溅急既酵饯究悈溍槿胶瞿铰卺噘捡戛楫唧鹪玑聚姣旌碣菊踺积接茳弆均径峧稷舰句氿觉皭菁缴牮齑珈佶检鸠苴芨具趄髻㛃阶车兼绝珏圈茄莒痂竭举儆浚枧碱洎籍系墐筥礓激洁艰焌崛跻伎跏夹竣腒叽遽兢茧久键屦岌忌搅郏藉玠狷谲攫筠蓟',
                    'k伉勘馗咯悝鹍狯郐诳库侩阃喹坎骷剀凯昆吭铿抠龈考圹框肯空浍科窥琨剋卡骙衎蔻砍呵况筐匡栝洘颏戣裈𡐓锴课蛞岿宽牁盔坤堃垦鲙拷开堪抗纩夔蒈嵁看扛邝靠恐括忾髋裤岢康慷溃圐颗嗑溘铠柯快㧟稞炣咖脍悃眍口狂崆硁匮贶姱侉裉龛蒯阔聩蝌苛磕楷烤髁篑亢磡枯蒉髡魁糠块客闶锞恺醌跬款垲𫛭坑刳啃瞰垮哙会槛夼绔𩾌崁挎氪扣侃埪硿葵愧傀逵骒栲莰馈𫸩缂孔控矻婫蝰珂克阚壳暌亏钪櫆犒㸆哭揩刊尻可揆旷夸棵坷恳瞌愦诓墈寇矿苦疴眶洭睽困奎隗恪轲筷咔慨筘胩倥锟刻胯叩窠跨鲲窟炌煃焜喀炕扩喟捆廓酷渴锎喾壸芤戡哐箜铐咳',
                    'l萝凛沥鹭疁类澜撩骝儡𫟅率溜叻咙猁吏姈裂捋烈葎累癗籁俪丽裸林筤鲢磊鹩楞膦帘邋良六痨娄琅疗缭粝摞熘麓蒌柳泺𦝼吝笠岭掳蓼轮狼虏勠沦戮梿俩栊祾蕗霖莨流剌绺罱傈落粮潋倮犁痢啰懔滦龙奁泷鸾赖捞苓嫠寮离缕烺氇𫚭喱禄辽𬬻遛敛狸撸璃荖蛎料量廉缆侣络聊硫㰀脸箖联骆楼镧墚莲鹠啷另栾垃轳略猡栎𬶠蒗颅姥砻陇嫘寥凉旒弄蓝榔篓老楝醪理廊棱骊靓梨辌铹赉坽𬬭鳞垆黧酪潾懒咧铃崃履箓擂裣鎏力李伦逯馏旯娌徕泐聋列崂坜珋甪仑𬶟廖灵蜡乐哩孪利猎蹽瘌仂俍鸬镏躏厘稑昤录陋陆鬣泪脟临冷濂垏椤簝垄蠡逦橹𫵷笼睐砾剅氯纶岚檩闾浏锣磏唳邻嫽连窿漉礼詈堎晾漻梁椋锊滤莅览砺僇跞雷玲铑殓龄咯𬕂驴莱洛浪滥醴泠俐铝诔聆榈澛蔺鞡癃卵癞来澧零励拎露梾婪偻獠烙抡卤躐绿啉藜论刘兰𪣻粱练圙谅庐囹罗篱撂辘锍勒蝼褴珑髅鸰凌裢螺疠喽拉揽拢篥啦醨璘翎了㮾崀俫屡嘞镂绫琭莉领峛郦立蛉飗菱虑劳骡缡鲁柃塄朗塱漯螂呤辂崚冽琏㫰嶙峦麟哢羸蕾锒卢魉镠蓏鲤芦瘘埌𬜯栳阑榴燎渌怜襕潦稂粒荦碌淋脔蓢㥄瘤瞭炉羚嵝耢历荔䴕涝戾镴锂蔹漓留耒肋例棂鲈褛遴菉憭箩垒鳢隆愣陵鹨蝲吕雳罹令娈膂尥辆瓴栗钌瑓礌俚炼珞两谰伶𫭢喇蜊逻砬亮缧栌链辚里涟璐琳疬篮镣郎鲮檑耧黎路漋酃粼厉佬烂胪䁖劣罶鳓旅眬溧罍隶噜踉泸镥悢鹿嘹琉舲牢磷廪掠胧镰橑洌挛藟𫭼鹂榄辣硌簕瞵𬒗髎䂮茏稆饹潞瘰恋濑銮瑬𪤗乱涞斓嫪拦律趔埒蠊囵漏栏镭雒赁赂腊搂脶酹阆僚唠捩',
                    'm殁迷牤抿麻茫麋媚呣秒钼缦锚泯鍪镁麽忙睦螟冕犸漠艨谬勉蟒磨铭模岷蛑敉瞢愍毪姆茗蓂木邙描妈縻沔苗目魔孟迈谩馍谋髦明募镘盟耄亹梅楙杩觅玛鹛锰煤秘鸣媄嘧莓马闷们牡姥眇𬙊苠麦硭摩闵牻瑁旄𧿹黾勔谜没拇梦无蜢祃鹋蒙缅缗卖旻帽缪蘑愐慕甍眯袤酩米眠蔓湄漭糜庙媒吗眸馒民邈貘嬷万嵋宓铆脒眊丏钔朦𬜬盲秣玫寞镅母杧湎脉猛懋茆蝥忞淼娩牟鞔貉莽𫞩每墁泌汨某弥珉昴貌膜玟咩摸靡芼美幕嫫码厖棉虻眉暝哞茅默名鬘寐亩貊溟劢皿洺买祢浼湣峁谟酶牧绵陌灭敏𩾃𬭁摹㠓密毛偭霉命闽猫懑埋嫚沐瑂猕芈妙冒渑沫末篾么弭漫萌抹侔醚悯曼幔鳘蚂洣瞒牦藐慢獴枚蘼苜墓礞冥镆渺矛魅谧孖焖仫蔑穆茂贸懵暮妹艋祕氓耱扪泖杪瞄蠓缈嘛面莫鳗喵瞀霾𫑡茉腼免墨瞑颟幂幪蛮袂门荬唛楣蟆乜骂满咪卯昧蓦螨芒檬勐尨蜜碈',
                    'n馁凝孥南孽您囊浓溺弄旎弩衲恁鼐霓柰那恧萳峱讷甯拟蹑糯奶乸倪泞努囡奴聂难酿脑捺拧赧农挪颞呶𬪩耐艿钠扭廿涅闹攮菍脲呐袅诺虐氖疟傉𫠜喏嵲嫩齉淖捏坭蘖拿怩垴孬娜妮𨺙楠媆搦撵咛镎内伲暖你腩脓腻苧瑙纽馕杻萘𫐐睨薿蔫硇怒鸟乃辗衄驽蝻辇迺猊黏狃铙妞耨年曩柠蛲镍笯狞侬陧佞懦恼拈能鲵逆男婻囔泥鲇碾忸聍拗奈呢昵宁尿臬胬麑猱嗫佴牛臑乜傩锘钕挠娘纳铌耏尼匿钮女镊哪喃哝砮粘啮捻𫔶𦰡茑肭埝秾念',
                    'o殴偶唔𬉼瓯噢藕沤耦欧区怄喔讴呕鸥𠙶',
                    'p刨屏辟贫辔趴璞氆嫔椪聘抔瞟墣怦批赔郫坯癖弸彭番堋俜镤濮醅胚枇帔圮苤炮裨抛凭芃评犏玭澎邳乓淜伾皮湃枰瞥螃片篇姘培砒普嘌菩嫖罴睥㛹瓢裴谱蟠便撇涄棚蚍噗庖怕硼磐铍圃蓬帕霹婆扁派判翩鹏拍脯暴蹼鳑陪平泮痞𬞟澼蹒骗坡杷抨湓频陂匹譬扒迫蹁否酦玶徘胖畔牝跑彷苉袢胼钷𬭯襻磅泼盘埤珀喷飘丕僻薸膀潽毗狍吡锫剽霈裒泡攀繁钋疱潘坪纰颇脬逄甓仆陴嘭荓盼叵脾堡拼滂筢劈瓶𡎚酺芘搒蜱谝品俳颦漂䥽狉盆骠鲆配琵屁啪苹碰披笸佩匍牌貔蒎蟛朴鄱耙泊砰沛掊槃咆𬇙琶葩旆呸洴票骈破䴙粕镨潖烹朋铺缥蚲穙排萍扑噼匏仳葡曝媲螵剖捧庞耪雱魄蒲乒篷娉哌爬氕淠泙叛𬳵溥袍旁衃殍楩埔鲏瀑膨疲啤磻浦爿皤偏',
                    'q且劝伽芹悭沁绮癯欠牵谴钎券倩脐裘郪勤訄柒橇囷钦覃起跂晴荃清璆綦䓛穷萩去棤灈其俏泉求仇逡龟却㭕窍仟汽葜萁杞劁鞧擒𨙸悫蕖岍鳅淇崎𫭟玘磜歧辁蛆愭虔䓖亟碛枪邛犍檎箐觑炝葺拤切硗苘憩耆掮扦氢亲蒨禽签犬沏呇樵𪨰泅龋遣趋锓岐酋囚羟抢裙卡瑔娶庆浅岂杄磲锜敲请确旗楸骐蜣秦羌犰茜鸲慬瞧腔奇劬启骑契堑廑亓𬘬邱碶蔃区芩桥揿苣趣矜圻琦缲权芑讫炔鼩颧渠鼽洽穹谯镪慊琪癿硚企萋蹊歉蠼鲭胠卿屺跄瘸磏弃曲麹谦坥竘筌祺钳埆佥婍祁锲蚯秋蜷噙钤郄蛴麇迄碃棋悄凄溱峤颀戗榷袷茕轻婘齐荠荨衾鞘纤丘蜻悛蕲鹊芪氰蘧芊栖巧芡虬峭惬嫱樯罄阒遒圲俅雀蔷蛐乞玱骎嘁乾愆棨椠前湫寝期驱荞鞒侨砌诮迁嵌箧强鲯器磬琴将糗阕顷青翘佺绻氍七伣恰欺缺诎踦畦屈侵蜞搴泣鹙缱群妻钱𨟠乔诠袪巯千瞿锹黥憔锖醛逑朐锵情襁岖漆筇檠銎黔取挈妾嗪痊衢铨鬈球髂趄擎掐阡躯倾圈茄潜跷棬气壳戚撬戕阙璩呛骞祛麒䓫怯嵚全赇勍铅祈拳鳍蛩圊琼黢窃肷墙鳈畎',
                    'r燃糅𫐓刃嬬扰嚅枘荏儴蚋衽轫蓉镕软禳饪攘缛稔若柔嵘溶冗润蒻婼任儒如汭锐壤桡堧髯偌入仞让茸蓐喏扔纴媆韧䎃瑞娆肉热乳榕驲染纫辱忍蠕薷孺饶冉蘘蕊溽绒濡蹂仁融狨妊嚷瓀人弱戎鄀认茹襦鞣蕤蚺瑢荣褥熔绕瀼阮洳铷汝荛闰壬揉爇箬睿容穰仍芮惹瓤苒蝾日然',
                    's糁螋擞送隋速飕扫仨虒唆宿荽磉涩鸶夙燧偲铯甦食梭锼卅潵锁思眭狻羧瞍蔌睢姒酥搜洒菘睃莎森澌肆祀淞嗽窣丝嗖似嵩丧穗笋愫粟艘噻瑟桑松稣蒐㟃溞耜苏觫岁梢竦咝僧孙琐谇荪靸汜馓兕随穑所溯祟嗓娀巳涑赛酸肃缫散蓑簌腮嗉鳃撒索嗍髓嗾斯忪讼啬襚臊狲缲耸𫟦颡涘锶寺饲鹔桫四嫂私蛳𬭼廋司㴔骕榫楒碎缩㧐隼损叟三虽脎色僳宋伺遂埽厮算叁素诉旞馊瘙撕毵蹜厕笥泗唢傃挲飧怂塑璱谡溲悚璲死飒蒜濉搡俟薮伞溹萨颂驷隧嗦嘶娑绥诵俗嗣骚缌崧搔邃塞',
                    't烔侗鲐涕豚韬啼荑锑𬘩驮绦桐荼覃鼗拖捅滔探晪镋腿镗棠叹坦铁跆曈笤吐跳稌挺箨梼陀陶鳎葶佗锬傥悌㻬湉淘萄瑭窕兔仝萚醍檀熥莛听同啕讨佟祧霆退萜沱酮梯唾彖圫垌𦒍囤凸桯绨掏抟裼柁湍髫塘璮葖焞螳汰擿誊俶阗田獭榻趿砼踏褟缇屉郯彤𬯎提贴坛庭朓坍橐汀钽黇縢谈𬳿峂圢痛遢畋堍粜骰趯瑅钛惔泰桶突淟龆洮蹋忒驼偷慆胎徒推逖烃筒僮惝薹耥托肽椭摊唐茼蹚痰忝钿炱掭䲢铜塌躺替剔𫘨嗵镡佃梌煓厅瞳峒趟套殄沺挞坉疼侂沓倘酴拓闼题蜓盷滩呔图恬鞳舔渟鲖邰菟童㛚汤蜩剃𫘦铽潭吞毯侹迢苕嘡踢叨鼍糖它嬥塔腯螣膛弢涂头屯漯臀绹惕通烫袒慝倜甜碳苔鹈体团忑投炭羰婷嚏饕弹橦堂菼阘调钍骀搪屠贪脱魋焘谭秃挑桃跎途透𬶍穜樘䣘柝太梃眺妥特鳀逃町庹榃藤坨腾滕条酞昙疃腆涛鲀澹铊铤恸饨帖䴘态暾啴帑螗媞潼珽嗒褪抬餮土添统他淌鲦猯颓天鸵艇佻倓台她砣𫍣亭酡停溻忐蜕瘫填蹄廷颋',
                    'u施申漴诗率侁沈拴述使筮胂勺食剡菽纱单悆身厍折莎数竖室腨蒴善识睡哨姗蛇售倏声抒恕仕舜掞裳酾沙邵晱闪痧烁叔绍属讪瘆昇赎泷甩捎省实婌鳝舒赏是瞬侍色士孰嗜擅砷乘赦上奭膳骦哂牲谥蜀烧燊楯授尚墡鸤弑蓍摔螫师瘦闩世圣试蔬释掺麝唰霜𬬹手婶势䏡嗄似𫚕骟梳爽嶦枢审黍搠陞深设屾山𪨶时轼纾慎帅疝蟀呻铄事拭疏收鲥铩煽射熟水受稍绶矢伤跚恃豕氏兽玿漱啥守劭猞蟮霎剩舍绱逝糁驶笙什舐葚𬤊朔淑商塾耍盛摄唼肾垧伸参娠匙埘芍沭狮杀妁礵砂铈帨槊鞘少觞刹曙瞫柿墒晌苕衰谂屎苫佘睄首隃硕示涮尸舢峙贳艄厦韶赊谁墅虱孀暑陎树渑潸双澍顺戍柖杓蜃庶晟栓税汕煞鲨狩殇腧潲矧禅视十掸噬寿陕书栅殊术奢殖始畲𫮃署甥式裟鲺饰傻史删梢甚市莳束吮鲹渗石社鼠适珅缮升滠绳杉阇说晒刷椹失召胜嘘谌慑歙输歃神熵扇鹴誓珊筛邿薯摅毹生湿涉赡绅拾衫蚀舌嵊姝栻莘',
                    'v鹯褚瞻株鳣准章笊丁诛晢洙蚱贽逐痄政筑折照砖喆朕阵砫楂整支盏盅辙识胗吒寨注锗睁帜梽翥挝蛭酎揕陟倬猪怔棁瘃仉疐镯瑱札酯撞㤘拯蓁辗哲终谆众蘸吱肫属者觯骘徵蒸谵帧主齇证纸蛰诼至滞助珍桎擢宙摘埴祭抓漳炙椎著织啄璋转壮鲊肢侄止赚诤找赭肘绽辀坠胝禚站浙偡沚粘周旐钲擿砟舳桩浊种圳衷籀诏症葴针濯螽𬶐缒稹扎拃瞩蜘喳冢旨雉侏丈展詟争汁伫竺纼踬疹庤赈震躅撰秩肇瑑昭臻肿𬸦痣棹嶂轸诌髽鹧斟箸智戆荮啭仲僮执值兆桌珠枳毡榨叕捉枝债湛侧昼掷帙战洲暲状妆斋樟职榰址植畤辄旃拽质搌婤眨缀隹胄鸷真酌祝追渣彘鬒啫杖汋之骓奓拄赘溱柘贞占飐长振沾苎赵瘵专𬃊杼狰馔蟑诸征掌栴𬘯幛踵指詹纣轴瘴致忮妯蔗豸茽重咋咒䓬屯烛柱张乍忠峙啁贮纻甄衠踯砧哳侦䃎窄障柊置谪咫爪劄鸩峥涨喋州箴晫绉只鲝宅焯账卓煮㑇芷颤栈趾铢铡涿闸篆晊郑麈钊朝䗪枕琢铮褶栉栅挚嘲竹䏝灼驻术中查帐穜朱殖碡榛郅桢奘袗沼絷粥槠沌传獐崭䦃铸斫疰正治窀翟芝制柷择知钟诈蛛诊渚忪幢住稙拙炷嘱轧着鸼罩缴庄茱椹蛀𬬿召直锥皱彰缜志椓遮栀挓窒曌炸招筝稚仗装脂磔𦭜嫜揸祉舟帚骤浞挣镇这锺禛轵胀烝溠锧茁颛僎痔斩惴畛祯',
                    'w午滃位洼峿廆喔鳁煨旿蜈武莴诿玟碗薳恶务卫皖紊㧑温烷枉宛苇卧阌幄梧惘艉无唔蕹王纹外沃𬱟豌芠玮𬶏涡危坞娃晚倭妩碨伟斡於佤剜蓊绾闻悟炆挝魍潍伪辋为问捂蔚汶𬇕兀鹀霨韪巍屋蔓湾妧𣲘牾未桅蜿崴迕璺微稳蚊偎歪袜仵忤辒雯偓鲔凹纬乌尪痿猬舞涠畏帷榅婠鹜丸涴挽巫慰嗡腽惟侮肟瓦菀呜刎𬭬尾魏忘诬鳚万伍吾维旺莞误娓硙窊鹉畹屼我罔瓮翁哇往谓勿塆椀𬭩网闱纨畖五物汪渥寤唯琬妄喂顽威葳完蜗晤腕委蛙𫘜韦薇洈芴毋珷味污龌帏婺芄惋焐𬀩芜尉望硪炜隗婉庑胃鹟吴窝娲钨瘟渭弯邬猥戊违亡骛萎圩挖脘玩雾圬踒逶吻文围握',
                    'x汹珝橡鳛泄袭荇嶍恤巡券铣祥仙衅襄蓿昔心嬉幸绡休胁悻飨猃姓箱芗栒旭茓谐霞巷䜣猩臭渲翕暹懈穴雄降猇狭傒掀宣芎新萧星㙦瘕湘铉觋镶罅涍绣谢弦效珛消蕈𬸣溴哓荀讯薪萱省腺驯熙徐暶歆腥羡响相嘻勋郗鲟雪垿饩刑跹巽兴须宵鑫熄希裼逍夐鞋枭筱鼷圩漩信下绪羲郤旬浒屑娴𫷷祆髹爔敩愃骁侠儇霰徇暇畜潟象膝缬跣叚觿析硖𫍯想僖曦偰些肖蓰昫𫓶茜炘琇线馐淅皙羞亵𠅤循宪馨禒契噱媳昡席饧郇窸隰寻隙锈凶迅栩潇牺苋枲陉埙兮泫啸洫馅薰写鹇忻𫄸喜熊熹荥榭玺勖吁蹊蜥莶浔翾削虚𬙋续呷像癣忺曛玄暿𫠊献孝汐颉叙轩噀崤薢珣奚孅蟹瞎廨洵絜硝讻偕霄峡虓绤𬩽岫宿匣蟋岘𫍲邢厢稀悉皛锨诩胥恔蓄鲑锡箫翔滫徙酗兄獯喧胸荨解薤藓纤惜𬶮殉学泻恂巇酰细樨笑携序邪唏性𬍤𫘬柙嗅婿釐项熏栖溪籼谑鸮挟煦行檄贤鸺烯向息芯衒䗛狝血选蟏惺厦小现洗絮汛辖晰翛谞冼夕魈瀣楔踅峋吸询蚬阋哮械禤限协顼香习销险校显先涎𪾢叶晓闲旋𦈡训陷勰洨逊貅庥糈昕形蝎擤𫍽许挦瑕遐媭绚煋铏夏葙黠醒珦痫咸见嚣醺晞欣鲞鲜撷歇鳕氙杏骧舷邂墟薛朽炫禧详硎饷辛咻㬎躞秀舾醯窨硒匈缃伈燮楦蛸嘘锌淆戌西乡享煊靴修浚卸县斜系衔虾嶲囟瑄璇嫌绁砉伭需溆盱枵脩袖型玹狎峃屣吓獬戏碹悬眩腊魆犀莘',
                    'y秧于杙䶮伢姨拥妖苡邕堉𬘡奄鹦栐役影妘荑𫄷食妤耀肴瘿裕晔逾箢𬮱严燕裔俨弇崟意芽琊玥𬸚𫘪瘀域兖懿陨堐涌垭援嶷渊曜於槱迎倻挹蝇蛇怡雁优育慵廙淹易阳纭荫鄘昱玚湲籥祐阉爰医狱郁腋怏盐愈彦垣舆蛹樱邑淤尾吲焱炀𬺈页铫阴谣谕引鲉御夭揖苑垸鱿鄞虞娅罨遹峄沿翊瘗窅压垠矣翳蝘咉狁俑蚴烊檐诒痍轺圫腰猗一㺄韵侥壹尉嫄揄蚓氩彧遇刖滪揠孕眼饫瑗癔英卣匀猷栎玡曰喻咽瑶沇阈楹与黝喑牖飏语讶禺痒唁音噎演螠游用珢羿样谊译已芸柚埇褕鹞丫焉臃鳐宇雨耘侑舀哑漾研殒歅慭疑右阎桠舣噫钖粤蔚胤庸妧甬魇钇岩㶲奕仰怨钰煜姻乐煴媱腌豫莜圆鳙竽益又铕睚谒唷隐圻郢泳爻韫訚蚁邺钥予伊缘艳渝荥硍腴诣溵赢咿吁屹摇盂佣窳甗圜胭艺耰赝圄蜒滟崦爷镒璎液踊䓨峪咦盈娱铀郧疣嚚愔郓熨珧胰尤约椅圉熠龠营簃有饔瑛幽蜮呀由攸绎莸移议押艾倚砚院鲬应颍渰愚荧萦萸言跃鱼氲囿淫赟龈靿肄岈誉蚜翌呦餍弋圯掩央㑊墉旸验恿远忧樾延鞅茔因永媛疟崾乂邀臆尧辕茚鸢颙晏员诱釉嗌越寓徭鋆缨峣厌棪焰曳衣仡洇逸嵛䲟禋油瀛猺缊菀烟咏嫕迂鄢屿眙姚映恹幺浴燏也寅觃洋氧瑜铘以衙轶瀹蝣迤恙筵狺银宴媵玉宥谚墕蜎饴掖泱鸯砑抑瘾觎宧颜依榆哕旖鼬隅酝耶妪遥叶沂蜴余鹰垚扬夷涯垟膺贻殷窈弈揶玙酉崖迓犹恽痈黟椰堰袁愿沅欲源铟偃云翼允硬庾饮掾𬸘眢原园佑薁疡预舁炎佾刈哟咬岳钺萤霪嘤芋爚戭漪滢殃晕业夜阅颐俞夤养佚冤悠禹猰仪月臾澭运滧靥芫𬟁毅鼋愉渔羽祎铱杳欤俣喁塬杨埸壅闫宜乙溢衍嬴茵幼撄勇窑遗窨野橼佯蕴𪩘说轧昀鼹薏呓猿莹龉悦驭莠尹元馌彝罂漹昳要印妍婴驿羕聿淯鹆镛浥亚吆愠雩溁鸦湮吟亦麀殪烨邮嫣氤亿蓥异鸳冶羊忆雍缢鹬颖鸭繇毓药疫牙莺狳筠𫐄琰雅徉友蓣义',
                    'z箦祚纂唑甑撮耔钻訾诹遭澡字宰唣则阻琢灶矰造兹姿仄觜眦咨慥锱鄑奏赜嵫酢粽早疭踪宗责坐增奘扎臧总走噂再𨱔左鲰鄫凿揍珇怎簪瓒驺鳟昃偬岞赠秭脏撙做族驵崽昝佐樽茈资辎牂滋藻龇柞足杂枞葬哉舴渍择躜倧暂缵笮啧憎赃作僔𥖨子纵组咋迮吱笫租在孜栽枣灾腙咂攥蕞陬最鲗拶滓胙遵甾躁匝籽嗞璪攒尊嘴糟卒捽缁载昨嶟阼祖鄹自藏寁锃缯俎皂鬷蚤臜仔崒趱罪咱淄酂紫座棕菹综曾呲砸镃嘬噪髭诅姊錾槜醉赚燥簉帻鬃贼趑泽梓鲻糌孳鼒罾怍谮邹赞恣',
                }
            }
        })
    end
}
