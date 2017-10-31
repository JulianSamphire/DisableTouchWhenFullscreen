;http://www.purebasic.fr/english/viewtopic.php?p=514197#p514197
EnableExplicit

;http://www.purebasic.fr/english/viewtopic.php?t=32319
Structure PROPVARIANT_CLIPDATA
  cbSize.l
  ulClipFmt.l
  *pClipData.BYTE
EndStructure

Structure PROPVARIANT_BSTRBLOB
  cbSize.l
  *pData.BYTE
EndStructure

Structure PROPVARIANT_BLOB
  cbSize.l
  *pBlobData.BYTE
EndStructure

Structure PROPVARIANT_VERSIONEDSTREAM
  guidVersion.GUID
  *pStream.IStream
EndStructure

Structure PROPVARIANT_CAC
  cElems.l
  *pElems.BYTE
EndStructure

Structure PROPVARIANT_CAUB
  cElems.l
  *pElems.BYTE
EndStructure

Structure PROPVARIANT_CAI
  cElems.l
  *pElems.WORD
EndStructure

Structure PROPVARIANT_CAUI
  cElems.l
  *pElems.WORD
EndStructure

Structure PROPVARIANT_CAL
  cElems.l
  *pElems.LONG
EndStructure

Structure PROPVARIANT_CAUL
  cElems.l
  *pElems.LONG
EndStructure

Structure PROPVARIANT_CAFLT
  cElems.l
  *pElems.FLOAT
EndStructure

Structure PROPVARIANT_CADBL
  cElems.l
  *pElems.DOUBLE
EndStructure

Structure PROPVARIANT_CACY
  cElems.l
  *pElems.QUAD
EndStructure

Structure PROPVARIANT_CADATE
  cElems.l
  *pElems.DOUBLE
EndStructure

Structure PROPVARIANT_CABSTR
  cElems.l
  *pElems.INTEGER
EndStructure

Structure PROPVARIANT_CABSTRBLOB
  cElems.l
  *pElems.PROPVARIANT_BSTRBLOB
EndStructure

Structure PROPVARIANT_CABOOL
  cElems.l
  *pElems.WORD
EndStructure

Structure PROPVARIANT_CASCODE
  cElems.l
  *pElems.LONG
EndStructure

Structure PROPVARIANT_CAPROPVARIANT
  cElems.l
  *pElems.PROPVARIANT
EndStructure

Structure PROPVARIANT_CAH
  cElems.l
  *pElems.QUAD
EndStructure

Structure PROPVARIANT_CAUH
  cElems.l
  *pElems.QUAD
EndStructure

Structure PROPVARIANT_CALPSTR
  cElems.l
  *pElems.INTEGER
EndStructure

Structure PROPVARIANT_CALPWSTR
  cElems.l
  *pElems.INTEGER
EndStructure

Structure PROPVARIANT_CAFILETIME
  cElems.l
  *pElems.FILETIME
EndStructure

Structure PROPVARIANT_CACLIPDATA
  cElems.l
  *pElems.PROPVARIANT_CLIPDATA
EndStructure

Structure PROPVARIANT_CACLSID
  cElems.l
  *pElems.CLSID
EndStructure

Structure PROPVARIANT Align #PB_Structure_AlignC
  vt.w
  wReserved1.w
  wReserved2.w
  wReserved3.w
  StructureUnion
    cVal.b
    bVal.b
    iVal.w
    uiVal.w
    lVal.l
    ulVal.l
    intVal.l
    uintVal.l
    hVal.q
    uhVal.q
    fltVal.f
    dblVal.d
    boolVal.w
    scode.l
    cyVal.q
    date.d
    filetime.FILETIME
    *puuid.CLSID
    *pclipdata.PROPVARIANT_CLIPDATA
    bstrVal.i
    bstrblobVal.PROPVARIANT_BSTRBLOB
    blob.PROPVARIANT_BLOB
    *pszVal
    *pwszVal
    *punkVal.IUnknown
    *pdispVal.IDispatch
    *pStream.IStream
    *pStorage.IStorage
    *pVersionedStream.PROPVARIANT_VERSIONEDSTREAM
    *parray.SAFEARRAY
    cac.PROPVARIANT_CAC
    caub.PROPVARIANT_CAUB
    cai.PROPVARIANT_CAI
    caui.PROPVARIANT_CAUI
    cal.PROPVARIANT_CAL
    caul.PROPVARIANT_CAUL
    cah.PROPVARIANT_CAH
    cauh.PROPVARIANT_CAUH
    caflt.PROPVARIANT_CAFLT
    cadbl.PROPVARIANT_CADBL
    cabool.PROPVARIANT_CABOOL
    cascode.PROPVARIANT_CASCODE
    cacy.PROPVARIANT_CACY
    cadate.PROPVARIANT_CADATE
    cafiletime.PROPVARIANT_CAFILETIME
    cauuid.PROPVARIANT_CACLSID
    caclipdata.PROPVARIANT_CACLIPDATA
    cabstr.PROPVARIANT_CABSTR
    cabstrblob.PROPVARIANT_CABSTRBLOB
    calpstr.PROPVARIANT_CALPSTR
    calpwstr.PROPVARIANT_CALPWSTR
    capropvar.PROPVARIANT_CAPROPVARIANT
    *pcVal.BYTE
    *pbVal.BYTE
    *piVal.WORD
    *puiVal.WORD
    *plVal.LONG
    *pulVal.LONG
    *pintVal.LONG
    *puintVal.LONG
    *pfltVal.FLOAT
    *pdblVal.DOUBLE
    *pboolVal.WORD
    *pdecVal.VARIANT_DECIMAL
    *pscode.LONG
    *pcyVal.QUAD
    *pdate.DOUBLE
    *pbstrVal.INTEGER
    *ppunkVal.INTEGER
    *ppdispVal.INTEGER
    *pparray.INTEGER
    *pvarVal.PROPVARIANT
  EndStructureUnion
EndStructure

Structure PROPERTYKEY
  fmtid.GUID  
  pid.l
EndStructure

Interface IPropertyStore Extends IUnknown
  GetCount.l(*cProps.LONG)
  GetAt.l(iProp.l, *pkey.PROPERTYKEY)
  GetValue.l(*key.PROPERTYKEY, *pv.PROPVARIANT)
  SetValue.l(*key.PROPERTYKEY, *propvar.PROPVARIANT)
  Commit.l()
EndInterface

Prototype SHGetPropertyStoreForWindow_(hWnd, *riid, *ppv)

ProcedureDLL DisableTouchWhenFullscreen(WindowID, State)
  Protected Result, LibraryID, SHGetPropertyStoreForWindow_.SHGetPropertyStoreForWindow_, CoInit, *ipropertystore.IPropertyStore, propertykey.PROPERTYKEY, propvariant.PROPVARIANT
  LibraryID = OpenLibrary(#PB_Any, "Shell32.dll")
  If LibraryID
    SHGetPropertyStoreForWindow_.SHGetPropertyStoreForWindow_ = GetFunction(LibraryID, "SHGetPropertyStoreForWindow")
    If SHGetPropertyStoreForWindow_
      CoInit = CoInitializeEx_(0, #COINIT_APARTMENTTHREADED | #COINIT_DISABLE_OLE1DDE)
      If CoInit = #S_OK Or CoInit = #S_FALSE Or CoInit & $FFFFFFFF = #RPC_E_CHANGED_MODE & $FFFFFFFF
        If SHGetPropertyStoreForWindow_(WindowID, ?IID_IPropertyStore, @*ipropertystore) = #ERROR_SUCCESS
          CopyMemory(?DISABLE_TOUCH_WHEN_FULLSCREEN, @propertykey\fmtid, SizeOf(GUID))
          propertykey\pid = 2
          propvariant\vt = #VT_BOOL
          If State
            propvariant\boolVal = #VARIANT_TRUE
          EndIf
          If *ipropertystore\SetValue(@propertykey, @propvariant) = #ERROR_SUCCESS
            Result = #True
          EndIf
          *ipropertystore\Release()
        EndIf
        If CoInit & $FFFFFFFF <> #RPC_E_CHANGED_MODE & $FFFFFFFF
          CoUninitialize_()
        EndIf
      EndIf
    EndIf
    CloseLibrary(LibraryID)
  EndIf
  ProcedureReturn Result
  DataSection
    IID_IPropertyStore:
      Data.l $886D8EEB
      Data.w $8CF2, $4446
      Data.b $8D, $02, $CD, $BA, $1D, $BD, $CF, $99
    DISABLE_TOUCH_WHEN_FULLSCREEN:
      Data.l $32CE38B2
      Data.w $2C9A, $41B1
      Data.b $9B, $C5, $B3, $78, $43, $94, $AA, $44
  EndDataSection
EndProcedure
; IDE Options = PureBasic 5.60 (Windows - x64)
; ExecutableFormat = Shared dll
; Folding = -
; EnableThread
; EnableXP
; Executable = DisableTouchWhenFullscreen.dll