@include "join" # gawk 4.1 was released in 2013

BEGIN {
    n_matches = 0;

    highlight_patterns = ENVIRON["PICKER_PATTERNS"]
    num_hints_needed = ENVIRON["NUM_HINTS_NEEDED"]
    blacklist = "(^\x1b\\[[0-9;]{1,9}m|^|[[:space:]:<>)(&#'\"])"ENVIRON["PICKER_BLACKLIST_PATTERNS"]"$"

    hint_format = ENVIRON["PICKER_HINT_FORMAT"]
    hint_format_nocolor = ENVIRON["PICKER_HINT_FORMAT_NOCOLOR"]
    hint_format_len = length(sprintf(hint_format_nocolor, ""))
    highlight_format = ENVIRON["PICKER_HIGHLIGHT_FORMAT"]
    compound_format = hint_format highlight_format

    # run gen_hints.py to (re-)generate it: 
    if (num_hints_needed <= 17) {
        split("s a d f j k l e w c m v b g h r u", HINTS);
    } else if (num_hints_needed <= 30) {
        split("s a d f j k l e w c m v b g h r us ua ud uf uj uk ul ue uw uc um uv ub ug", HINTS);
    } else if (num_hints_needed <= 50) {
        split("s a d f j k l e w c m v b g hs ha rs ra rd rf rj rk rl re rw rc rm rv rb rg rh rr ru us ua ud uf uj uk ul ue uw uc um uv ub ug uh ur uu", HINTS);
    } else if (num_hints_needed <= 80) {
        split("s a d f j k l e w c m v b gs ga gd gf gj gk gl ge gw gc gm gv gb gg gh gr hs ha hd hf hj hk hl he hw hc hm hv hb hg hh hr hu rs ra rd rf rj rk rl re rw rc rm rv rb rg rh rr ru us ua ud uf uj uk ul ue uw uc um uv ub ug uh ur uu", HINTS);
    } else if (num_hints_needed <= 110) {
        split("s a d f j k l e w c m vs va vd vf vj vk vl ve vw vc vm vv vb vg bs ba bd bf bj bk bl be bw bc bm bv bb bg bh br bu gs ga gd gf gj gk gl ge gw gc gm gv gb gg gh gr gu hs ha hd hf hj hk hl he hw hc hm hv hb hg hh hr hu rs ra rd rf rj rk rl re rw rc rm rv rb rg rh rr ru us ua ud uf uj uk ul ue uw uc um uv ub ug uh ur uu", HINTS);
    } else if (num_hints_needed <= 150) {
        split("s a d f j k l e ws wa wd wf wj wk cs ca cd cf cj ck cl ce cw cc cm cv cb cg ch cr cu ms ma md mf mj mk ml me mw mc mm mv mb mg mh mr mu vs va vd vf vj vk vl ve vw vc vm vv vb vg vh vr vu bs ba bd bf bj bk bl be bw bc bm bv bb bg bh br bu gs ga gd gf gj gk gl ge gw gc gm gv gb gg gh gr gu hs ha hd hf hj hk hl he hw hc hm hv hb hg hh hr hu rs ra rd rf rj rk rl re rw rc rm rv rb rg rh rr ru us ua ud uf uj uk ul ue uw uc um uv ub ug uh ur uu", HINTS);
    } else if (num_hints_needed <= 200) {
        split("s a d f j ks ka kd kf kj kk kl ke ls la ld lf lj lk ll le lw lc lm lv lb lg lh lr lu es ea ed ef ej ek el ee ew ec em ev eb eg eh er eu ws wa wd wf wj wk wl we ww wc wm wv wb wg wh wr wu cs ca cd cf cj ck cl ce cw cc cm cv cb cg ch cr cu ms ma md mf mj mk ml me mw mc mm mv mb mg mh mr mu vs va vd vf vj vk vl ve vw vc vm vv vb vg vh vr vu bs ba bd bf bj bk bl be bw bc bm bv bb bg bh br bu gs ga gd gf gj gk gl ge gw gc gm gv gb gg gh gr gu hs ha hd hf hj hk hl he hw hc hm hv hb hg hh hr hu rs ra rd rf rj rk rl re rw rc rm rv rb rg rh rr ru us ua ud uf uj uk ul ue uw uc um uv ub ug uh ur uu", HINTS);
    } else if (num_hints_needed <= 300) {
        split("ss sa sd sf sj sk sl se sw sc sm sv sb sg sh sr su as aa ad af aj ak al ae aw ac am av ab ag ah ar au ds da dd df dj dk dl de dw dc dm dv db dg dh dr du fs fa fd ff fj fk fl fe fw fc fm fv fb fg fh fr fu js ja jd jf jj jk jl je jw jc jm jv jb jg jh jr ju ks ka kd kf kj kk kl ke kw kc km kv kb kg kh kr ku ls la ld lf lj lk ll le lw lc lm lv lb lg lh lr lu es ea ed ef ej ek el ee ew ec em ev eb eg eh er eu ws wa wd wf wj wk wl we ww wc wm wv wb wg wh wr wu cs ca cd cf cj ck cl ce cw cc cm cv cb cg ch cr cu ms ma md mf mj mk ml me mw mc mm mv mb mg mh mr mu vs va vd vf vj vk vl ve vw vc vm vv vb vg vh vr vu bs ba bd bf bj bk bl be bw bc bm bv bb bg bh br bu gs ga gd gf gj gk gl ge gw gc gm gv gb gg gh gr gu hs ha hd hf hj hk hl he hw hc hm hv hb hg hh hr hu rs ra rd rf rj rk rl re rw rc rm rv rb rg rh rr ru us ua ud uf uj uk ul ue uw uc um uv ub ug uh ur uus uua uud uuf uuj uuk uul uue uuw uuc uum uuv", HINTS);
    } else if (num_hints_needed <= 500) {
        split("ss sa sd sf sj sk sl se sw sc sm sv sb sg sh sr su as aa ad af aj ak al ae aw ac am av ab ag ah ar au ds da dd df dj dk dl de dw dc dm dv db dg dh dr du fs fa fd ff fj fk fl fe fw fc fm fv fb fg fh fr fu js ja jd jf jj jk jl je jw jc jm jv jb jg jh jr ju ks ka kd kf kj kk kl ke kw kc km kv kb kg kh kr ku ls la ld lf lj lk ll le lw lc lm lv lb lg lh lr lu es ea ed ef ej ek el ee ew ec em ev eb eg eh er eu ws wa wd wf wj wk wl we ww wc wm wv wb wg wh wr wu cs ca cd cf cj ck cl ce cw cc cm cv cb cg ch cr cu ms ma md mf mj mk ml me mw mc mm mv mb mg mh mr mu vs va vd vf vj vk vl ve vw vc vm vv vb vg vh vr vu bs ba bd bf bj bk bl be bw bc bm bv bb bg bh br bu gs ga gd gf gj gk gl ge gw gc gm gv gb gg gh gr gu hs ha hd hf hj hk hl he hw hc hm hv hb hg hh hr hu rs ra rd rf rj rk rl re rw rc rm rv rb rg rh rr ru us ua ud ufs ufa ufd uff ujs uja ujd ujf ujj ujk ujl uje ujw ujc ujm ujv ujb ujg ujh ujr uju uks uka ukd ukf ukj ukk ukl uke ukw ukc ukm ukv ukb ukg ukh ukr uku uls ula uld ulf ulj ulk ull ule ulw ulc ulm ulv ulb ulg ulh ulr ulu ues uea ued uef uej uek uel uee uew uec uem uev ueb ueg ueh uer ueu uws uwa uwd uwf uwj uwk uwl uwe uww uwc uwm uwv uwb uwg uwh uwr uwu ucs uca ucd ucf ucj uck ucl uce ucw ucc ucm ucv ucb ucg uch ucr ucu ums uma umd umf umj umk uml ume umw umc umm umv umb umg umh umr umu uvs uva uvd uvf uvj uvk uvl uve uvw uvc uvm uvv uvb uvg uvh uvr uvu ubs uba ubd ubf ubj ubk ubl ube ubw ubc ubm ubv ubb ubg ubh ubr ubu ugs uga ugd ugf ugj ugk ugl uge ugw ugc ugm ugv ugb ugg ugh ugr ugu uhs uha uhd uhf uhj uhk uhl uhe uhw uhc uhm uhv uhb uhg uhh uhr uhu urs ura urd urf urj urk url ure urw urc urm urv urb urg urh urr uru uus uua uud uuf uuj uuk uul uue uuw uuc uum uuv uub uug uuh uur uuu", HINTS);
    } else {
        split("ss sa sd sf sj sk sl se sw sc sm sv sb sg sh sr su as aa ad af aj ak al ae aw ac am av ab ag ah ar au ds da dd df dj dk dl de dw dc dm dv db dg dh dr du fs fa fd ff fj fk fl fe fw fc fm fv fb fg fh fr fu js ja jd jf jj jk jl je jw jc jm jv jb jg jh jr ju ks ka kd kf kj kk kl ke kw kc km kv kb kg kh kr ku ls la ld lf lj lk ll le lw lc lm lv lb lg lh lr lu es ea ed ef ej ek el ee ew ec em ev eb eg eh er eu ws wa wd wf wj wk wl we ww wc wm wv wb wg wh wr wu cs ca cd cf cj ck cl ce cw cc cm cv cb cg ch cr cu ms ma md mf mj mk ml me mw mc mm mv mb mg mh mr mu vs va vd vf vj vk vl ve vw vc vm vv vb vg vh vr vu bs ba bd bf bj bk bl be bw bc bm bv bb bg bh br bu gs ga gd gf gj gk gl ge gw gc gm gv gb gg gh gr gu hs ha hd hf hj hk hls hla hld hlf hlj hlk hll hle hes hea hed hef hej hek hel hee hew hec hem hev heb heg heh her heu hws hwa hwd hwf hwj hwk hwl hwe hww hwc hwm hwv hwb hwg hwh hwr hwu hcs hca hcd hcf hcj hck hcl hce hcw hcc hcm hcv hcb hcg hch hcr hcu hms hma hmd hmf hmj hmk hml hme hmw hmc hmm hmv hmb hmg hmh hmr hmu hvs hva hvd hvf hvj hvk hvl hve hvw hvc hvm hvv hvb hvg hvh hvr hvu hbs hba hbd hbf hbj hbk hbl hbe hbw hbc hbm hbv hbb hbg hbh hbr hbu hgs hga hgd hgf hgj hgk hgl hge hgw hgc hgm hgv hgb hgg hgh hgr hgu hhs hha hhd hhf hhj hhk hhl hhe hhw hhc hhm hhv hhb hhg hhh hhr hhu hrs hra hrd hrf hrj hrk hrl hre hrw hrc hrm hrv hrb hrg hrh hrr hru hus hua hud huf huj huk hul hue huw huc hum huv hub hug huh hur huu rss rsa rsd rsf rsj rsk rsl rse rsw rsc rsm rsv rsb rsg rsh rsr rsu ras raa rad raf raj rak ral rae raw rac ram rav rab rag rah rar rau rds rda rdd rdf rdj rdk rdl rde rdw rdc rdm rdv rdb rdg rdh rdr rdu rfs rfa rfd rff rfj rfk rfl rfe rfw rfc rfm rfv rfb rfg rfh rfr rfu rjs rja rjd rjf rjj rjk rjl rje rjw rjc rjm rjv rjb rjg rjh rjr rju rks rka rkd rkf rkj rkk rkl rke rkw rkc rkm rkv rkb rkg rkh rkr rku rls rla rld rlf rlj rlk rll rle rlw rlc rlm rlv rlb rlg rlh rlr rlu res rea red ref rej rek rel ree rew rec rem rev reb reg reh rer reu rws rwa rwd rwf rwj rwk rwl rwe rww rwc rwm rwv rwb rwg rwh rwr rwu rcs rca rcd rcf rcj rck rcl rce rcw rcc rcm rcv rcb rcg rch rcr rcu rms rma rmd rmf rmj rmk rml rme rmw rmc rmm rmv rmb rmg rmh rmr rmu rvs rva rvd rvf rvj rvk rvl rve rvw rvc rvm rvv rvb rvg rvh rvr rvu rbs rba rbd rbf rbj rbk rbl rbe rbw rbc rbm rbv rbb rbg rbh rbr rbu rgs rga rgd rgf rgj rgk rgl rge rgw rgc rgm rgv rgb rgg rgh rgr rgu rhs rha rhd rhf rhj rhk rhl rhe rhw rhc rhm rhv rhb rhg rhh rhr rhu rrs rra rrd rrf rrj rrk rrl rre rrw rrc rrm rrv rrb rrg rrh rrr rru rus rua rud ruf ruj ruk rul rue ruw ruc rum ruv rub rug ruh rur ruu uss usa usd usf usj usk usl use usw usc usm usv usb usg ush usr usu uas uaa uad uaf uaj uak ual uae uaw uac uam uav uab uag uah uar uau uds uda udd udf udj udk udl ude udw udc udm udv udb udg udh udr udu ufs ufa ufd uff ufj ufk ufl ufe ufw ufc ufm ufv ufb ufg ufh ufr ufu ujs uja ujd ujf ujj ujk ujl uje ujw ujc ujm ujv ujb ujg ujh ujr uju uks uka ukd ukf ukj ukk ukl uke ukw ukc ukm ukv ukb ukg ukh ukr uku uls ula uld ulf ulj ulk ull ule ulw ulc ulm ulv ulb ulg ulh ulr ulu ues uea ued uef uej uek uel uee uew uec uem uev ueb ueg ueh uer ueu uws uwa uwd uwf uwj uwk uwl uwe uww uwc uwm uwv uwb uwg uwh uwr uwu ucs uca ucd ucf ucj uck ucl uce ucw ucc ucm ucv ucb ucg uch ucr ucu ums uma umd umf umj umk uml ume umw umc umm umv umb umg umh umr umu uvs uva uvd uvf uvj uvk uvl uve uvw uvc uvm uvv uvb uvg uvh uvr uvu ubs uba ubd ubf ubj ubk ubl ube ubw ubc ubm ubv ubb ubg ubh ubr ubu ugs uga ugd ugf ugj ugk ugl uge ugw ugc ugm ugv ugb ugg ugh ugr ugu uhs uha uhd uhf uhj uhk uhl uhe uhw uhc uhm uhv uhb uhg uhh uhr uhu urs ura urd urf urj urk url ure urw urc urm urv urb urg urh urr uru uus uua uud uuf uuj uuk uul uue uuw uuc uum uuv uub uug uuh uur uuu", HINTS);
    }

    hint_lookup = ""
}

{
    line = $0;
    output_line = "";
    post_match = line;
    skipped_prefix = "";

    # Inserts hints into `output_line` and accumulate hints in `hint_lookup`
    while (match(line, highlight_patterns, matches)) {
        pre_match = skipped_prefix substr(line, 1, RSTART - 1);
        post_match = substr(line, RSTART + RLENGTH);
        line_match = matches[0]

        if (line_match !~ blacklist) {
            # All sub-patterns start with a prefix group (sometimes empty) that should not be highlighted, e.g.
            #     ((prefix_a)(item_a))|((prefix_b)(item_a))
            # So matches array is looks like: 
            #    ||||prefix_b item_b|prefix_b|item_b|
            #    or    
            #    |prefix_a item_a|prefix_a|item_a||||
            # Unfortunately, we don't know the index of first matching group.
            num_groups = length(matches) / 3; # array contains: idx, idx-start, idx-length for each group
            for (i = 1; i <= num_groups; i++) {
                if (matches[i] != "") {
                    line_match = substr(line_match, 1 + matches[++i, "length"])
                    pre_match = pre_match matches[i]
                    break;
                }
            }

            hint = hint_by_match[line_match]
            if (!hint) {
                hint = HINTS[++n_matches]
                hint_by_match[line_match] = hint
                hint_lookup = hint_lookup hint ":" line_match "\n"
            }

            hint_len = length(hint) + hint_format_len;
            line_match = substr(line_match, hint_len + 1, length(line_match) - hint_len);
            line_match = sprintf(compound_format, hint, line_match);

            # Fix colors broken by the hints highlighting.
            # This is mostly needed to keep prompts intact, so fix first ~500 chars only
            if (length(output_line) < 500) { 
                num_colors = split(pre_match, arr, /\x1b\[[0-9;]{1,9}m/, colors); 
                post_match = join(colors, 1, 1 + num_colors, SUBSEP) post_match;
            }

            output_line = output_line pre_match line_match;
            skipped_prefix = "";
        } else {
            skipped_prefix = pre_match line_match; # we need it only to fix colors
        }
        line = post_match;
    }

    printf "\n%s", (output_line skipped_prefix post_match)
}

END {
    print hint_lookup | "cat 1>&3"
}
