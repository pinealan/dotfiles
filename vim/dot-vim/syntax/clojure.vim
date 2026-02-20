" Vim indent file
" Language:           Clojure
" Maintainer:         Alex Vear <alex@vear.uk>
" Former Maintainers: Sung Pae <self@sungpae.com>
"                     Meikel Brandmeyer <mb@kotka.de>
"                     Toralf Wittner <toralf.wittner@gmail.com>
" Contributors:       Joel Holdbrooks <cjholdbrooks@gmail.com> (Regexp support, bug fixes)
" URL:                https://github.com/clojure-vim/clojure.vim
" License:            Vim (see :h license)
" Last Change:        2022-03-24

if exists("b:current_syntax")
	finish
endif

let s:cpo_sav = &cpo
set cpo&vim

if has("folding") && exists("g:clojure_fold") && g:clojure_fold > 0
	setlocal foldmethod=syntax
endif

" -*- KEYWORDS -*-
" Generated from https://github.com/clojure-vim/clojure.vim/blob/fd280e33e84c88e97860930557dba3ff80b1a82d/clj/src/vim_clojure_static/generate.clj
" Clojure version 1.11.0
let s:clojure_syntax_keywords = {
	\ 'clojureBoolean': ["false","true"],
	\ 'clojureCond': ["case","case*","clojure.core/case","clojure.core/cond","clojure.core/cond->","clojure.core/cond->>","clojure.core/condp","clojure.core/if-let","clojure.core/if-not","clojure.core/if-some","clojure.core/when","clojure.core/when-first","clojure.core/when-let","clojure.core/when-not","clojure.core/when-some","cond","cond->","cond->>","condp","if","if-let","if-not","if-some","when","when-first","when-let","when-not","when-some"],
	\ 'clojureConstant': ["nil"],
	\ 'clojureDefine': ["clojure.core/definline","clojure.core/definterface","clojure.core/defmacro","clojure.core/defmethod","clojure.core/defmulti","clojure.core/defn","clojure.core/defn-","clojure.core/defonce","clojure.core/defprotocol","clojure.core/defrecord","clojure.core/defstruct","clojure.core/deftype","definline","definterface","defmacro","defmethod","defmulti","defn","defn-","defonce","defprotocol","defrecord","defstruct","deftype","deftype*"],
	\ 'clojureException': ["catch","finally","throw","try"],
	\ 'clojureMacro': ["->","->>","..","amap","and","areduce","as->","assert","binding","bound-fn","clojure.core/->","clojure.core/->>","clojure.core/..","clojure.core/amap","clojure.core/and","clojure.core/areduce","clojure.core/as->","clojure.core/assert","clojure.core/binding","clojure.core/bound-fn","clojure.core/comment","clojure.core/declare","clojure.core/delay","clojure.core/dosync","clojure.core/doto","clojure.core/extend-protocol","clojure.core/extend-type","clojure.core/for","clojure.core/future","clojure.core/gen-class","clojure.core/gen-interface","clojure.core/import","clojure.core/io!","clojure.core/lazy-cat","clojure.core/lazy-seq","clojure.core/locking","clojure.core/memfn","clojure.core/ns","clojure.core/or","clojure.core/proxy","clojure.core/proxy-super","clojure.core/pvalues","clojure.core/refer-clojure","clojure.core/reify","clojure.core/some->","clojure.core/some->>","clojure.core/sync","clojure.core/time","clojure.core/vswap!","clojure.core/with-bindings","clojure.core/with-in-str","clojure.core/with-loading-context","clojure.core/with-local-vars","clojure.core/with-open","clojure.core/with-out-str","clojure.core/with-precision","clojure.core/with-redefs","comment","declare","delay","dosync","doto","extend-protocol","extend-type","for","future","gen-class","gen-interface","import","io!","lazy-cat","lazy-seq","locking","memfn","ns","or","proxy","proxy-super","pvalues","refer-clojure","reify","some->","some->>","sync","time","vswap!","with-bindings","with-in-str","with-loading-context","with-local-vars","with-open","with-out-str","with-precision","with-redefs"],
	\ 'clojureRepeat': ["clojure.core/doseq","clojure.core/dotimes","clojure.core/loop","clojure.core/while","doseq","dotimes","loop","loop*","recur","while"],
	\ 'clojureSpecial': ["&",".","clojure.core/fn","clojure.core/import*","clojure.core/let","clojure.core/letfn","def","do","fn","fn*","let","let*","letfn","letfn*","monitor-enter","monitor-exit","new","quote","reify*","set!","var"],
	\ 'clojureVariable': ["*1","*2","*3","*agent*","*allow-unresolved-vars*","*assert*","*clojure-version*","*command-line-args*","*compile-files*","*compile-path*","*compiler-options*","*data-readers*","*default-data-reader-fn*","*e","*err*","*file*","*flush-on-newline*","*fn-loader*","*in*","*math-context*","*ns*","*out*","*print-dup*","*print-length*","*print-level*","*print-meta*","*print-namespace-maps*","*print-readably*","*read-eval*","*reader-resolver*","*source-path*","*suppress-read*","*unchecked-math*","*use-context-classloader*","*verbose-defrecords*","*warn-on-reflection*","EMPTY-NODE","Inst","char-escape-string","char-name-string","clojure.core/*1","clojure.core/*2","clojure.core/*3","clojure.core/*agent*","clojure.core/*allow-unresolved-vars*","clojure.core/*assert*","clojure.core/*clojure-version*","clojure.core/*command-line-args*","clojure.core/*compile-files*","clojure.core/*compile-path*","clojure.core/*compiler-options*","clojure.core/*data-readers*","clojure.core/*default-data-reader-fn*","clojure.core/*e","clojure.core/*err*","clojure.core/*file*","clojure.core/*flush-on-newline*","clojure.core/*fn-loader*","clojure.core/*in*","clojure.core/*math-context*","clojure.core/*ns*","clojure.core/*out*","clojure.core/*print-dup*","clojure.core/*print-length*","clojure.core/*print-level*","clojure.core/*print-meta*","clojure.core/*print-namespace-maps*","clojure.core/*print-readably*","clojure.core/*read-eval*","clojure.core/*reader-resolver*","clojure.core/*source-path*","clojure.core/*suppress-read*","clojure.core/*unchecked-math*","clojure.core/*use-context-classloader*","clojure.core/*verbose-defrecords*","clojure.core/*warn-on-reflection*","clojure.core/EMPTY-NODE","clojure.core/Inst","clojure.core/char-escape-string","clojure.core/char-name-string","clojure.core/default-data-readers","clojure.core/primitives-classnames","clojure.core/print-dup","clojure.core/print-method","clojure.core/unquote","clojure.core/unquote-splicing","default-data-readers","primitives-classnames","print-dup","print-method","unquote","unquote-splicing"]
	\ }

function! s:syntax_keyword(dict)
	for key in keys(a:dict)
		execute 'syntax keyword' key join(a:dict[key], ' ')
	endfor
endfunction

if exists('b:clojure_syntax_without_core_keywords') && b:clojure_syntax_without_core_keywords
	" Only match language specials and primitives
	for s:key in ['clojureBoolean', 'clojureConstant', 'clojureException', 'clojureSpecial']
		execute 'syntax keyword' s:key join(s:clojure_syntax_keywords[s:key], ' ')
	endfor
else
	call s:syntax_keyword(s:clojure_syntax_keywords)
endif

if exists('g:clojure_syntax_keywords')
	call s:syntax_keyword(g:clojure_syntax_keywords)
endif

if exists('b:clojure_syntax_keywords')
	call s:syntax_keyword(b:clojure_syntax_keywords)
endif

unlet! s:key
delfunction s:syntax_keyword

" Keywords are symbols:
"   static Pattern symbolPat = Pattern.compile("[:]?([\\D&&[^/]].*/)?([\\D&&[^/]][^/]*)");
" But they:
"   * Must not end in a : or /
"   * Must not have two adjacent colons except at the beginning
"   * Must not contain any reader metacharacters except for ' and #
syntax match clojureKeyword "\v<:{1,2}([^ \n\r\t()\[\]{}";@^`~\\/]+/)*[^ \n\r\t()\[\]{}";@^`~\\/]+:@1<!>"

syntax match clojureStringEscape "\v\\%([\\btnfr"]|u\x{4}|[0-3]\o{2}|\o{1,2})" contained

syntax region clojureString matchgroup=clojureStringDelimiter start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=clojureStringEscape,@Spell

syntax match clojureCharacter "\v\\%(o%([0-3]\o{2}|\o{1,2})|u\x{4}|newline|tab|space|return|backspace|formfeed|.)"

syntax match clojureSymbol "\v%([a-zA-Z!$&*_+=|<.>?-]|[^\x00-\x7F])+%(:?%([a-zA-Z0-9!#$%&*_+=|'<.>/?-]|[^\x00-\x7F]))*[#:]@1<!"

" NB. Correct matching of radix literals was removed for better performance.
syntax match clojureNumber "\v<[-+]?%(%([2-9]|[12]\d|3[0-6])[rR][[:alnum:]]+|%(0\o*|0x\x+|[1-9]\d*)N?|%(0|[1-9]\d*|%(0|[1-9]\d*)\.\d*)%(M|[eE][-+]?\d+)?|%(0|[1-9]\d*)/%(0|[1-9]\d*))>"

syntax match clojureQuote "\v['`]"
syntax match clojureUnquote "\v\~\@?"
syntax match clojureMeta "\^"
syntax match clojureDeref "@"
syntax match clojureDispatch "\v#[\^'=<_]?"

" Clojure permits no more than 20 anonymous params.
syntax match clojureAnonArg "%\(20\|1\d\|[1-9]\|&\)\?"

syntax match  clojureRegexpEscape "\v\\%([\\tnrfae.()\[\]{}^$*?+]|c\u|0[0-3]?\o{1,2}|x%(\x{2}|\{\x{1,6}\})|u\x{4})" contained display
syntax region clojureRegexpQuoted start=/\\Q/ms=e+1 skip=/\\\\\|\\"/ end=/\\E/me=s-1 end=/"/me=s-1 contained
syntax region clojureRegexpQuote  start=/\\Q/       skip=/\\\\\|\\"/ end=/\\E/       end=/"/me=s-1 contains=clojureRegexpQuoted keepend contained

" -*- CHARACTER PROPERTY CLASSES -*-
" Generated from https://github.com/clojure-vim/clojure.vim/blob/fd280e33e84c88e97860930557dba3ff80b1a82d/clj/src/vim_clojure_static/generate.clj
" Java version 17.0.2
syntax match clojureRegexpPosixCharClass "\v\\[pP]\{%(Cntrl|A%(l%(pha|num)|SCII)|Space|Graph|Upper|P%(rint|unct)|Blank|XDigit|Digit|Lower)\}" contained display
syntax match clojureRegexpJavaCharClass "\v\\[pP]\{java%(Whitespace|JavaIdentifier%(Part|Start)|SpaceChar|Mirrored|TitleCase|I%(SOControl|de%(ographic|ntifierIgnorable))|D%(efined|igit)|U%(pperCase|nicodeIdentifier%(Part|Start))|L%(etter%(OrDigit)?|owerCase)|Alphabetic)\}" contained display
syntax match clojureRegexpUnicodeCharClass "\v\\[pP]\{\cIs%(l%(owercase|etter)|hex%(digit|_digit)|w%(hite%(_space|space)|ord)|noncharacter%(_code_point|codepoint)|p%(rint|unctuation)|ideographic|graph|a%(l%(num|phabetic)|ssigned)|uppercase|join%(control|_control)|titlecase|blank|digit|control)\}" contained display
syntax match clojureRegexpUnicodeCharClass "\v\\[pP][NSCMZPL]" contained display
syntax match clojureRegexpUnicodeCharClass "\v\\[pP]\{%(N[dlo]?|P[dcifeos]?|C[ncfos]?|M[nce]?|Z[lsp]?|S[mcko]?|L[muCDlto]?)\}" contained display
syntax match clojureRegexpUnicodeCharClass "\v\\[pP]\{%(Is|gc\=|general_category\=)?%(N[dlo]?|P[dcifeos]?|C[ncfos]?|M[nce]?|Z[lsp]?|S[mcko]?|L[muCDlto]?)\}" contained display
syntax match clojureRegexpUnicodeCharClass "\v\\[pP]\{\c%(Is|sc\=|script\=)%(k%(its|h%(oj%(ki)?|m%(r|er)|itan_small_script|udawadi|ar%(oshthi)?)|a%(li|n%(a|nada)|takana%(_or_hiragana)?|yah_li|ithi)|nda|thi)|r%(ohg|un%(ic|r)|ejang|jng)|l%(epc%(ha)?|i%(mbu?|n%([ab]|ear_[ab])|su)|y%([dc]i%(an)?)|a%(t%(n|in)|na|oo?))|t%(elu%(gu)?|ha%(i|a%(na)?)|i%(finagh|rh%(uta)?|b%(t|etan))|fng|glg|a%(i_%(le|tham|viet)|g%(alog|b%(anwa)?)|vt|kri?|ng%(ut)?|l[ue]|m%(il|l)))|vaii?|y%(i%(ii)?|ezi%(di)?)|e%(thi%(opic)?|l%(ym%(aic)?|ba%(san)?)|gyp%(tian_hieroglyphs)?)|u%(gar%(itic)?|nknown)|h%(ung|ira%(gana)?|rkt|mn[gp]|a%(n%(i%(fi_rohingya)?|unoo|o|g%(ul)?)?|tr%(an)?)|luw|ebr%(ew)?)|g%(r%(e%(k|ek)|an%(tha)?)|lag%(olitic)?|eor%(gian)?|o%(n[mg]|th%(ic)?)|u%(j%(arati|r)|r%(u|mukhi)|njala_gondi))|m%(lym|a%(n%(d%(aic)?|i%(chaean)?)|saram_gondi|h%(ajani|j)|ka%(sar)?|rc%(hen)?|layalam)|o%(di|ng%(olian)?)|e%(r%(c|o%(itic_%(hieroglyphs|cursive))?)|etei_mayek|nd%(e_kikakui)?|d%(f|efaidrin))|roo?|y%(anmar|mr)|tei|iao|ult%(ani)?)|d%(upl%(oyan)?|srt|i%(ak|ves_akuru)|ogra?|e%(seret|va%(nagari)?))|z%(an%(abazar_square|b)|inh|yyy|zzz)|n%(yiakeng_puachue_hmong|bat|koo?|ew%(_tai_lue|a)|ushu|shu|a%(bataean|rb|nd%(inagari)?))|s%(h%(rd|a%(vian|rada|w))|o%(yo%(mbo)?|g%(d%(ian)?|o)|ra%(_sompeng)?)|i%(n%(d|h%(ala)?)|dd%(ham)?|gnwriting)|a%(ur%(ashtra)?|m%(r|aritan)|rb)|y%(r%(c|iac)|lo%(ti_nagri)?)|und%(anese)?|gnw)|w%(cho|a%(ncho|ra%(ng_citi)?))|c%(y%(priot|r%(l|illic))|h%(er%(okee)?|a%(m|kma)|rs|orasmian)|a%(km|ucasian_albanian|n%(adian_aboriginal|s)|ri%(an)?)|prt|uneiform|o%(pt%(ic)?|mmon))|i%(n%(scriptional_pa%(rthian|hlavi)|herited)|mperial_aramaic|tal)|p%(h%(l[ip]|oenician|ag%(s_pa)?|nx)|a%(lm%(yrene)?|u%(_cin_hau|c)|hawh_hmong)|rti|salter_pahlavi|lrd|erm)|x%(peo|sux)|b%(eng%(ali)?|ra%(i%(lle)?|h%(mi)?)|opo%(mofo)?|u%(gi%(nese)?|h%(d|id))|h%(ks|aiksuki)|a%(ss%(a_vah)?|t%(ak|k)|li%(nese)?|mum?))|java%(nese)?|o%(g%(am|ham)|s%(age|ge|ma%(nya)?)|l%(d_%(hungarian|north_arabian|so%(gdian|uth_arabian)|per%(mic|sian)|italic|turkic)|ck|_chiki)|r%(iya|kh|ya))|a%(r%(ab%(ic)?|m%([ni]|enian))|dl%(m|am)|natolian_hieroglyphs|hom|v%(st|estan)|ghb))\}" contained display
syntax match clojureRegexpUnicodeCharClass "\v\\[pP]\{\c%(In|blk\=|block\=)%(zanabazar%([ _]square|square)|javanese|h%(a%(lfwidth%( and fullwidth forms|andfullwidthforms|_and_fullwidth_forms)|tran|n%(unoo|gul%(compatibilityjamo|syllables|jamo%(extended\-[ab])?|_%(syllables|jamo%(_extended_[ab])?|compatibility_jamo)| %(syllables|compatibility jamo|jamo%( extended\-[ab])?))|ifi%([_ ]rohingya|rohingya)))|i%(ragana|gh%( %(private use surrogates|surrogates)|_%(private_use_surrogates|surrogates)|surrogates|privateusesurrogates))|ebrew)|i%(pa%([ _]extensions|extensions)|n%(scriptional%(%([ _]pa%(rthian|hlavi))|pa%(rthian|hlavi))|dic%(siyaqnumbers|_siyaq_numbers| siyaq numbers))|deographic%(symbolsandpunctuation|_%(description_characters|symbols_and_punctuation)| %(description characters|symbols and punctuation)|descriptioncharacters)|mperial%(aramaic|[_ ]aramaic))|c%(o%(ntrol%(pictures|[ _]pictures)|ptic%(epactnumbers|_epact_numbers| epact numbers)?|m%(mon%(_indic_number_forms|indicnumberforms| indic number forms)|bining%(halfmarks|_%(diacritical_marks%(_%(supplement|for_symbols|extended))?|marks_for_symbols|half_marks)| %(half marks|diacritical marks%( %(supplement|for symbols|extended))?|marks for symbols)|diacriticalmarks%(supplement|forsymbols|extended)?|marksforsymbols))|unting%( rod numerals|_rod_numerals|rodnumerals))|a%(rian|ucasian%([ _]albanian|albanian))|jk%(unifiedideographs%(extension[dgacfbe])?|s%(ymbolsandpunctuation|trokes)|_%(s%(trokes|ymbols_and_punctuation)|radicals_supplement|unified_ideographs%(_extension_[dgacfbe])?|compatibility%(_%(forms|ideographs%(_supplement)?))?)|compatibility%(forms|ideographs%(supplement)?)?|radicalssupplement| %(compatibility%( %(ideographs%( supplement)?|forms))?|unified ideographs%( extension [dgacfbe])?|radicals supplement|s%(ymbols and punctuation|trokes)))|y%(rillic%(supplement%(ary)?| %(supplement%(ary)?|extended\-[acb])|extended\-[acb]|_%(extended_[acb]|supplement%(ary)?))?|priot%(syllabary|[ _]syllabary))|u%(rrency%([_ ]symbols|symbols)|neiform%(_numbers_and_punctuation|numbersandpunctuation| numbers and punctuation)?)|h%(e%(ss%([_ ]symbols|symbols)|rokee%(supplement|[ _]supplement)?)|a%(m|kma)|orasmian))|g%(othic|u%(njala%(gondi|[_ ]gondi)|jarati|rmukhi)|lagolitic%(supplement|[ _]supplement)?|e%(o%(rgian%(supplement|%([_ ]%(supplement|extended))|extended)?|metric%( shapes%( extended)?|shapes%(extended)?|_shapes%(_extended)?))|neral%([_ ]punctuation|punctuation))|r%(eek%( %(and coptic|extended)|andcoptic|_%(and_coptic|extended)|extended)?|antha))|s%(h%(orthand%( format controls|_format_controls|formatcontrols)|a%(vian|rada))|u%(ndanese%(supplement|[ _]supplement)?|p%(erscripts%(_and_subscripts|andsubscripts| and subscripts)|plementa%(ry%(_private_use_area_[ab]|privateusearea\-[ab]| private use area\-[ab])|l%( %(mathematical operators|symbols and pictographs|punctuation|arrows\-[acb])|symbolsandpictographs|mathematicaloperators|punctuation|arrows\-[acb]|_%(arrows_[acb]|symbols_and_pictographs|mathematical_operators|punctuation))))|tton%(signwriting|[_ ]signwriting))|i%(nhala%( archaic numbers|archaicnumbers|_archaic_numbers)?|ddham)|y%(loti%([_ ]nagri|nagri)|mbols%( %(for legacy computing|and pictographs extended\-a)|forlegacycomputing|andpictographsextended\-a|_%(and_pictographs_extended_a|for_legacy_computing))|riac%(supplement|[ _]supplement)?)|p%(acing%(_modifier_letters| modifier letters|modifierletters)|ecials)|a%(maritan|urashtra)|o%(yombo|gdian|ra%(sompeng|[ _]sompeng))|mall%(kanaextension| %(kana extension|form variants)|_%(kana_extension|form_variants)|formvariants))|y%(i%(syllables|%([_ ]%(syllables|radicals))|radicals|jing%(hexagramsymbols| hexagram symbols|_hexagram_symbols))|ezidi)|p%(h%(o%(enician|netic%( extensions%( supplement)?|extensions%(supplement)?|_extensions%(_supplement)?))|a%(istos%([ _]disc|disc)|gs[_\-]pa))|laying%(cards|[_ ]cards)|rivate%(usearea| use area|_use_area)|a%(hawh%(hmong|[_ ]hmong)|u%(_cin_hau|cinhau| cin hau)|lmyrene)|salter%(pahlavi|[ _]pahlavi))|e%(l%(basan|ymaic)|arly%(_dynastic_cuneiform|dynasticcuneiform| dynastic cuneiform)|moticons|gyptian%(hieroglyph%(formatcontrols|s)| hieroglyph%( format controls|s)|_hieroglyph%(_format_controls|s))|nclosed%( %(cjk letters and months|ideographic supplement|alphanumeric%( supplement|s))|cjklettersandmonths|_%(ideographic_supplement|alphanumeric%(_supplement|s)|cjk_letters_and_months)|alphanumerics%(upplement)?|ideographicsupplement)|thiopic%(supplement|_%(supplement|extended%(_a)?)| %(supplement|extended%(\-a)?)|extended%(\-a)?)?)|r%(u%(nic|mi%(numeralsymbols| numeral symbols|_numeral_symbols))|ejang)|d%(o%(gra|mino%([ _]tiles|tiles))|e%(seret|vanagari%([ _]extended|extended)?)|uployan|i%(ngbats|ves%([_ ]akuru|akuru)))|m%(e%(defaidrin|nde%([ _]kikakui|kikakui)|etei%(mayek%(extensions)?|_mayek%(_extensions)?| mayek%( extensions)?)|roitic%(hieroglyphs|%([_ ]%(hieroglyphs|cursive))|cursive))|o%(ngolian%(supplement|[ _]supplement)?|di%(fier%(_tone_letters| tone letters|toneletters))?)|ro|u%(ltani|sical%([_ ]symbols|symbols))|i%(ao|scellaneous%(technical|symbols%(and%(pictographs|arrows))?|mathematicalsymbols\-[ab]| %(technical|mathematical symbols\-[ab]|symbols%( and %(pictographs|arrows))?)|_%(technical|symbols%(_and_%(pictographs|arrows))?|mathematical_symbols_[ab])))|yanmar%( extended\-[ab]|extended\-[ab]|_extended_[ab])?|a%(h%(ajani|jong%([ _]tiles|tiles))|rchen|n%(daic|ichaean)|yan%([_ ]numerals|numerals)|saram%(gondi|[_ ]gondi)|layalam|thematical%(alphanumericsymbols| %(alphanumeric symbols|operators)|_%(alphanumeric_symbols|operators)|operators)|kasar))|o%(s%(age|manya)|ttoman%(siyaqnumbers|_siyaq_numbers| siyaq numbers)|r%(namental%([ _]dingbats|dingbats)|iya)|ptical%( character recognition|_character_recognition|characterrecognition)|gham|l%([ _]chiki|d%(hungarian| %(hungarian|so%(uth arabian|gdian)|per%(mic|sian)|north arabian|italic|turkic)|per%(mic|sian)|so%(utharabian|gdian)|italic|turkic|_%(hungarian|north_arabian|so%(gdian|uth_arabian)|per%(mic|sian)|italic|turkic)|northarabian)|chiki))|n%(ew%(_tai_lue|a|tailue| tai lue)|ko|yiakeng%( puachue hmong|puachuehmong|_puachue_hmong)|a%(bataean|ndinagari)|u%(shu|mber%(forms|[ _]forms)))|b%(u%(ginese|hid)|a%(s%(sa%([ _]vah|vah)|ic%([ _]latin|latin))|linese|mum%(supplement|[ _]supplement)?|tak)|ra%(hmi|ille%(patterns|[_ ]patterns))|o%(x%([ _]drawing|drawing)|pomofo%([ _]extended|extended)?)|lock%([ _]elements|elements)|haiksuki|yzantine%( musical symbols|musicalsymbols|_musical_symbols)|engali)|l%(i%(mbu|near%(a| %(a|b %(ideograms|syllabary))|b%(ideograms|syllabary)|_%(a|b_%(ideograms|syllabary)))|su%(supplement|[ _]supplement)?)|a%(tin%(extended%(\-[dacbe]|additional)|_%(extended_%([dcbe]|a%(dditional)?)|1_supplement)|\-1%(supplement| supplement)| extended%(\-[dacbe]| additional))|o)|e%(tterlike%([_ ]symbols|symbols)|pcha)|ow%([_ ]surrogates|surrogates)|y[cd]ian)|k%(h%(aroshthi|ojki|mer%([_ ]symbols|symbols)?|udawadi|itan%( small script|smallscript|_small_script))|a%(takana%(_phonetic_extensions|phoneticextensions| phonetic extensions)?|n%(gxi%([_ ]radicals|radicals)|a%(extended\-a|supplement| %(extended\-a|supplement)|_%(supplement|extended_a))|bun|nada)|ithi|yah%([ _]li|li)))|wa%(ncho|rang%(citi|[ _]citi))|t%(elugu|ransport%( and map symbols|_and_map_symbols|andmapsymbols)|i%(rhuta|betan|finagh)|a%(mil%(supplement|[ _]supplement)?|kri|ngut%(supplement|%([ _]%(supplement|components))|components)?|i%(xuanjingsymbols|_%(le|xuan_jing_symbols|tham|viet)|le| %(xuan jing symbols|le|tham|viet)|tham|viet)|g%(alog|s|banwa))|ha%(i|ana))|a%(l%(chemical%([_ ]symbols|symbols)|phabetic%( presentation forms|_presentation_forms|presentationforms))|n%(cient%(_%(greek_%(musical_notation|numbers)|symbols)|greek%(numbers|musicalnotation)| %(greek %(numbers|musical notation)|symbols)|symbols)|atolian%([ _]hieroglyphs|hieroglyphs))|dlam|r%(menian|abic%(extended\-a|mathematicalalphabeticsymbols|supplement|_%(presentation_forms_[ab]|supplement|extended_a|mathematical_alphabetic_symbols)| %(extended\-a|mathematical alphabetic symbols|supplement|presentation forms\-[ab])|presentationforms\-[ab])?|rows)|egean%(numbers|[ _]numbers)|vestan|hom)|u%(garitic|nified%(canadianaboriginalsyllabics%(extended)?|_canadian_aboriginal_syllabics%(_extended)?| canadian aboriginal syllabics%( extended)?))|v%(a%(i|riation%( selectors%( supplement)?|selectors%(supplement)?|_selectors%(_supplement)?))|e%(rtical%(forms|[ _]forms)|dic%([ _]extensions|extensions))))\}" contained display

syntax match   clojureRegexpPredefinedCharClass "\v%(\\[dDsSwW]|\.)" contained display
syntax cluster clojureRegexpCharPropertyClasses contains=clojureRegexpPosixCharClass,clojureRegexpJavaCharClass,clojureRegexpUnicodeCharClass
syntax cluster clojureRegexpCharClasses         contains=clojureRegexpPredefinedCharClass,clojureRegexpCharClass,@clojureRegexpCharPropertyClasses
syntax region  clojureRegexpCharClass           start="\[" skip=/\\\\\|\\]/ end="]" contained contains=clojureRegexpPredefinedCharClass,@clojureRegexpCharPropertyClasses
syntax match   clojureRegexpBoundary            "\\[bBAGZz]" contained display
syntax match   clojureRegexpBoundary            "[$^]" contained display
syntax match   clojureRegexpQuantifier          "[?*+][?+]\=" contained display
syntax match   clojureRegexpQuantifier          "\v\{\d+%(,|,\d+)?}\??" contained display
syntax match   clojureRegexpOr                  "|" contained display
syntax match   clojureRegexpBackRef             "\v\\%([1-9]\d*|k\<[[:alpha:]]+\>)" contained display

" Mode modifiers, mode-modified spans, lookaround, regular and atomic
" grouping, and named-capturing.
syntax match clojureRegexpMod "\v\(@<=\?:" contained display
syntax match clojureRegexpMod "\v\(@<=\?[xdsmiuU]*-?[xdsmiuU]+:?" contained display
syntax match clojureRegexpMod "\v\(@<=\?%(\<?[=!]|\>)" contained display
syntax match clojureRegexpMod "\v\(@<=\?\<[[:alpha:]]+\>" contained display

syntax region clojureRegexpGroup start="(" skip=/\\\\\|\\)/ end=")" matchgroup=clojureRegexpGroup contained contains=clojureRegexpMod,clojureRegexpQuantifier,clojureRegexpBoundary,clojureRegexpEscape,@clojureRegexpCharClasses
syntax region clojureRegexp matchgroup=clojureRegexpDelimiter start=/\#"/ skip=/\\\\\|\\"/ end=/"/ contains=@clojureRegexpCharClasses,clojureRegexpEscape,clojureRegexpQuote,clojureRegexpBoundary,clojureRegexpQuantifier,clojureRegexpOr,clojureRegexpBackRef,clojureRegexpGroup keepend

syntax keyword clojureCommentTodo contained FIXME XXX TODO BUG NOTE HACK FIXME: XXX: TODO: BUG: NOTE: HACK:

syntax match clojureComment ";.*$" contains=clojureCommentTodo,@Spell
syntax match clojureComment "#!.*$"
syntax match clojureComment ","

" Comment out discarded forms.  <https://clojure.org/guides/weird_characters#_discard>
if exists('g:clojure_discard_macro') && g:clojure_discard_macro
	syntax region clojureDiscard matchgroup=clojureDiscard start=/#_[ ,\t\n`'~]*/   end=/[, \t\n()\[\]{}";]/me=e-1
	syntax region clojureDiscard matchgroup=clojureDiscard start=/#_[ ,\t\n`'~]*"/  skip=/\\[\\"]/ end=/"/
	syntax region clojureDiscard matchgroup=clojureDiscard start=/#_[ ,\t\n`'~]*(/  end=/)/  contains=clojureDiscardForm
	syntax region clojureDiscard matchgroup=clojureDiscard start=/#_[ ,\t\n`'~]*\[/ end=/\]/ contains=clojureDiscardForm
	syntax region clojureDiscard matchgroup=clojureDiscard start=/#_[ ,\t\n`'~]*{/  end=/}/  contains=clojureDiscardForm

	syntax region clojureDiscardForm start="("  end=")"  contained contains=clojureDiscardForm
	syntax region clojureDiscardForm start="{"  end="}"  contained contains=clojureDiscardForm
	syntax region clojureDiscardForm start="\[" end="\]" contained contains=clojureDiscardForm
endif

" -*- TOP CLUSTER -*-
" Generated from https://github.com/clojure-vim/clojure.vim/blob/fd280e33e84c88e97860930557dba3ff80b1a82d/clj/src/vim_clojure_static/generate.clj
syntax cluster clojureTop contains=@Spell,clojureAnonArg,clojureBoolean,clojureCharacter,clojureComment,clojureCond,clojureConstant,clojureDefine,clojureDeref,clojureDiscard,clojureDispatch,clojureError,clojureException,clojureFunc,clojureKeyword,clojureMacro,clojureMap,clojureMeta,clojureNumber,clojureQuote,clojureRegexp,clojureRepeat,clojureSexp,clojureSpecial,clojureString,clojureSymbol,clojureUnquote,clojureVariable,clojureVector

syntax region clojureSexp   matchgroup=clojureParen start="("  end=")" contains=@clojureTop fold
syntax region clojureVector matchgroup=clojureParen start="\[" end="]" contains=@clojureTop fold
syntax region clojureMap    matchgroup=clojureParen start="{"  end="}" contains=@clojureTop fold

" Highlight superfluous closing parens, brackets and braces.
syntax match clojureError "]\|}\|)"

" @AlanChan Very custom rules
syntax match clojureNSSlash "[a-zA-Z0-9!#$%&*_+=|'<.>/?-]\@1<=/\ze[a-zA-Z0-9!#$%&*_+=|'<.>/?-]" contained containedin=clojureKeyword,clojureSymbol
syntax match clojureKeyword "\v<:{1,2}%([^ \n\r\t()\[\]{}";@^`~\\/]+/)*[^ \n\r\t()\[\]{}";@^`~\\/]+:@<!>"
syntax match clojureVariable "&[:a-zA-Z0-9!#$%&*_+='|<.>/?-]\+"

syntax match clojureFunc    "(\@1<=[a-zA-Z0-9!$&*_+=|<.>?-][:a-zA-Z0-9!#$%&*_+='|<.>/?-]*" contains=ALLBUT,@clojureRegexpCharPropertyClasses,@clojureRegexpCharClasses,clojureRegexpMod,clojureRegexpQuantifier,clojureSymbol,clojureAnonArg,clojureRegexpBoundary,clojureRegexpBoundary,clojureQuote

syntax sync fromstart

highlight default link clojureConstant                  Constant
highlight default link clojureBoolean                   Boolean
highlight default link clojureCharacter                 Character
highlight default link clojureKeyword                   Keyword
highlight default link clojureNumber                    Number
highlight default link clojureString                    String
highlight default link clojureStringDelimiter           String
highlight default link clojureStringEscape              Character

highlight default link clojureRegexp                    Constant
highlight default link clojureRegexpDelimiter           Constant
highlight default link clojureRegexpEscape              Character
highlight default link clojureRegexpCharClass           SpecialChar
highlight default link clojureRegexpPosixCharClass      clojureRegexpCharClass
highlight default link clojureRegexpJavaCharClass       clojureRegexpCharClass
highlight default link clojureRegexpUnicodeCharClass    clojureRegexpCharClass
highlight default link clojureRegexpPredefinedCharClass clojureRegexpCharClass
highlight default link clojureRegexpBoundary            SpecialChar
highlight default link clojureRegexpQuantifier          SpecialChar
highlight default link clojureRegexpMod                 SpecialChar
highlight default link clojureRegexpOr                  SpecialChar
highlight default link clojureRegexpBackRef             SpecialChar
highlight default link clojureRegexpGroup               clojureRegexp
highlight default link clojureRegexpQuoted              clojureString
highlight default link clojureRegexpQuote               clojureRegexpBoundary

highlight default link clojureVariable                  Identifier
highlight default link clojureCond                      Conditional
highlight default link clojureDefine                    Define
highlight default link clojureException                 Exception
highlight default link clojureFunc                      Function
highlight default link clojureMacro                     Macro
highlight default link clojureRepeat                    Repeat

highlight default link clojureSpecial                   Special
highlight default link clojureQuote                     SpecialChar
highlight default link clojureUnquote                   SpecialChar
highlight default link clojureMeta                      SpecialChar
highlight default link clojureDeref                     SpecialChar
highlight default link clojureAnonArg                   SpecialChar
highlight default link clojureDispatch                  SpecialChar

highlight default link clojureComment                   Comment
highlight default link clojureCommentTodo               Todo
highlight default link clojureDiscard                   clojureComment
highlight default link clojureDiscardForm               clojureDiscard

highlight default link clojureError                     Error

highlight default link clojureParen                     Delimiter
highlight default link clojureNSSlash                   Delimiter

" LSP
highlight link @lsp.mod.definition.clojure      NONE
highlight link @lsp.type.function.clojure       NONE
highlight link @lsp.type.variable.clojure       NONE
highlight link @lsp.type.macro.clojure          clojureMacro

let b:current_syntax = "clojure"

let &cpo = s:cpo_sav
unlet! s:cpo_sav

" vim:sts=8:sw=8:ts=8:noet
