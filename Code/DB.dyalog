:Namespace DB

    _filetie←0
    AllTimeKeys←100 100⊥(6/0,⍳23),[.5](6×24)⍴0 10 20 30 40 50

    ∇ r←FileTie;ix
      :If _filetie=0
          ix←(↓⎕FNAMES)⍳⊂FileName
          :If ix>≢⎕FNAMES
              _filetie←Open
          :Else
              _filetie←⎕FNUMS[ix]
          :EndIf
      :EndIf
      r←_filetie
    ∇
    ∇ r←Fields;NL
      NL←⎕UCS 10
      r←'TimeSlot StartTS EndTS inv# # minTemp maxTemp SumTemp SumTempSq powerGenerated(WHr)'
      r,←NL
      r,←'1       2-8     9-15  16  17   18      19      20         21         22          '
    ∇


    ∇ fn←FileName
      fn←1⊃⎕NPARTS ⎕WSID
      fn,←'Databases'
      fn,←'/sensors'
     
    ∇

    ∇ tn←Open;fn
      fn←FileName
      :If 0=⎕NEXISTS fn,'.dcf'
          FileTie←New fn
      :Else
          FileTie←fn ⎕FSTIE 0
      :EndIf
    ∇

    ∇ tn←New FileName;cn
      tn←FileName ⎕FCREATE 0
      'HB Sensor Database'⎕FAPPEND tn
      (0 2⍴'' 0)⎕FAPPEND tn
      (8⍴(''))⎕FAPPEND¨tn
    ∇

    ∇ dir←GetDir measure;measures;mix
      measures←⎕FREAD FileTie 2
      mix←measures[;1]⍳⊂measure
      :If mix>≢measures
          dir←0 2⍴0
      :Else
          dir←⎕FREAD FileTie,measures[mix;2]
      :EndIf
    ∇

    DateKeyFromTS←{100 100 100⊥3↑⍵}
    TimeKeyFromTS←{100 100⊥2↑3↓⍵}

    ⍝Get a whole day (ts) of measure m
    ∇ r←m GetDay ts;dir;key;ix
      dir←GetDir m
      key←DateKeyFromTS ts
      ix←dir[;1]⍳key
      :If ix>≢dir
          r←0 0⍴0
      :Else
          r←⎕FREAD FileTie,dir[ix;2]
      :EndIf
     
    ∇





    ∇ Put record;timekey;datadir;mix;measures;tablekey;datekey;timestamp;measure;d;kt;dir;tabs;tix;dix;data
      measure←⊃record
      timestamp←⊃1↓record
      datekey←DateKeyFromTS timestamp
      timekey←TimeKeyFromTS timestamp
        ⍝
      data←timekey,↑⊃2↓record
⍝      :Hold #.⍙FileTie
⍝          ⎕FHOLD FileTie
      measures←⎕FREAD FileTie 2
      mix←measures[;1]⍳⊂measure
      :If mix>≢measures
          measures⍪←(measure)(''⎕FAPPEND FileTie)
          measures ⎕FREPLACE FileTie 2
      :EndIf
      datadir←⎕FREAD FileTie,measures[mix;2]
      dix←datadir[;1]⍳datekey
      :If dix>≢datadir
          datadir⍪←(datekey)(((0,1↓⍴data)⍴0)⎕FAPPEND FileTie)
          datadir ⎕FREPLACE FileTie,measures[mix;2]
      :EndIf
      data←(⎕FREAD FileTie(datadir[dix;2]))⍪data
      data ⎕FREPLACE FileTie(datadir[dix;2])
      ⎕FUNTIE ⍬
 ⍝         ⎕FHOLD ⍬
 ⍝     :EndHold
     
    ∇







:EndNamespace
