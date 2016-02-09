Strict 

Import srs.Win32

Import "dxgi_ng.bmx"
Import "d3dcommon_ng.bmx"
Import "d3d11_common.bmx"

Extern"win32"

Interface ID3D11DeviceChild Extends IUnknown_
	Method GetDevice()
	Method GetPrivateData()
	Method SetPrivateData()
	Method SetPrivateDataInterface()
EndInterface 

Interface ID3D11DepthStencilState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11BlendState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11RasterizerState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Resource Extends ID3D11DeviceChild
	Method GetType()
	Method SetEvictionPriority()
	Method GetEvictionPriority()
EndInterface 

Interface ID3D11Buffer Extends ID3D11Resource
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Texture1D Extends ID3D11Resource
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Texture2D Extends ID3D11Resource	
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Texture3D Extends ID3D11Resource
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11View Extends ID3D11DeviceChild
	Method GetResource(ppResource:ID3D11Resource Var)
EndInterface 

Interface ID3D11ShaderResourceView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11RenderTargetView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11DepthStencilView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11UnorderedAccessView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11VertexShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11HullShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11DomainShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11GeometryShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11PixelShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11ComputeShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11InputLayout Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11SamplerState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Asynchronous Extends ID3D11DeviceChild
	Method GetDataSize()
EndInterface 

Interface ID3D11Query Extends ID3D11Asynchronous
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Predicate Extends ID3D11Query
EndInterface 

Interface ID3D11Counter Extends ID3D11Asynchronous
	Method GetDesc(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11ClassInstance Extends ID3D11DeviceChild
	Method GetClassLinkage(ppLinkage:ID3D11ClassLinkage Var)
	Method GetDesc(pDesc:Byte Ptr)
	Method GetInstanceName(pInstanceName:Byte Ptr,pBufferLength)
	Method GetTypeName(pTypeName:Byte Ptr,pBufferLength)
EndInterface 

Interface ID3D11ClassLinkage Extends ID3D11DeviceChild
	Method GetClassInstance(pClassInstanceName:Byte Ptr,InstanceIndex,ppInstance:ID3D11ClassInstance Var)
	Method CreateClassInstance(pszClassTypeName:Byte,ConstantBufferOffset,ConstantVectorOffset,TextureOffset,SamplerOffset,ppInstsance:ID3D11ClassInstance Var)
EndInterface 

Interface ID3D11CommandList Extends ID3D11DeviceChild
	Method GetContextFlags()
EndInterface 

Interface ID3D11DeviceContext Extends ID3D11DeviceChild
	Method VSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method PSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method PSSetShader(pPixelShader:ID3D11PixelShader,ppClassInstances:Byte Ptr,NumClassInstances)
	Method PSSetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method VSSetShader(pVertexShader:ID3D11VertexShader,ppClassInstances:Byte Ptr,NumClassInstances)
	Method DrawIndexed(IndexCount,StartIndexLocation,BaseVertexLocation)
	Method Draw(VertexCount,StartVertexLocation)
	Method Map(pResource:ID3D11Resource,Subresource,MapType,MapFlags,pMappedResource:Byte Ptr)
	Method UnMap(pResource:ID3D11Resource,Subresource)
	Method PSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method IASetInputLayout(pInputLayout:ID3D11InputLayout)
	Method IASetVertexBuffers(StartSlot,NumBuffers,ppVertexBuffers:Byte Ptr,pStrides:Byte Ptr,pOffsets:Byte Ptr)
	Method IASetIndexBuffer(pIndexBuffer:ID3D11Buffer,Format,Offset)
	Method DrawIndexedInstanced(IndexCountPerInstance,InstanceCount,StartIndexLocation,BaseVertexLocation,StartInstanceLocation)
	Method DrawInstanced(VertexCountPerInstance,InstanceCount,StartVertexLocation,StartInstanceLocation)
	Method GSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method GSSetShader(pShader:ID3D11GeometryShader,ppClassInstance:Byte Ptr,NumClassInstances)
	Method IASetPrimitiveTopology(Topology)
	Method VSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method VSSetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method Begin(pAsync:ID3D11Asynchronous)
	Method End_(pAsync:ID3D11Asynchronous)
	Method GetData(pAsync:ID3D11Asynchronous,pData:Byte Ptr,DataSize,GetDataFlags)
	Method SetPredication(pPredicate:ID3D11Predicate,PredicateValue)
	Method GSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method GSSetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method OMSetRenderTargets(NumViews,ppRenderTargetViews:Byte Ptr,pDepthStencilView:Byte Ptr)
	Method OMSetRendetTargetsAndUnorderedAccessViews(NumViews,ppRenderTargetViews:Byte Ptr,ppDepthStencilView:ID3D11DepthStencilView Var,UAVStartSlot,NumUAVs,ppUnorderedAccessViews:Byte Ptr)
	Method OMSetBlendState(pBlendState:ID3D11BlendState,BlendFactor:Byte Ptr,SampleMask)
	Method OMSetDepthStencilState(pDepthStencilState:ID3D11DepthStencilState,StencilRef)
	Method SOSetTargets(NumBuffers,ppSOTargets:Byte Ptr,pOffsets:Byte Ptr)
	Method DrawAuto()
	Method DrawIndexedInstancedIndirect(pBufferForArgs:ID3D11Buffer,AlignedByteOffsetForArgs)
	Method DrawInstancedIndirect(pBufferForArgs:ID3D11Buffer,AlignedByteOffsetForArgs)
	Method Dispatch(ThreadGroupCountX,ThreadGroupCountY,ThreadCountZ)
	Method DispatchIndirect(pBufferForArgs:ID3D11Buffer,AlignedOffsetForArgs)
	Method RSSetState(pRasterizerState:ID3D11RasterizerState)
	Method RSSetViewports(NumViewports,pViewports:Byte Ptr)
	Method RSSetScissorRects(NumRects,pRects:Byte Ptr)
	Method CopySubresourceRegion(pDstResource:ID3D11Resource,DstSubresource,DstX,DstY,DstZ,pSrcResource:ID3D11Resource,SrcSubresource,pSrcBox:Byte Ptr)
	Method CopyResource(pDstResource:ID3D11Resource,pSrcResource:ID3D11Resource)
	Method UpdateSubresource(pDstResource:ID3D11Resource,DstSubresource,pDstBox:Byte Ptr,pSrcData:Byte Ptr,SrcRowPitch,SrcDepthPitch)
	Method CopyStructureCount(pDstBuffer:ID3D11Buffer,DstAlignedByteOffset,pSrcView:ID3D11UnorderedAccessView)
	Method ClearRenderTargetView(pRenderTargetView:ID3D11RenderTargetView,ColorRGBA:Byte Ptr)
	Method ClearUnorderedAccessViewUint(pUnorderedAccessView:ID3D11UnorderedAccessView,Values:Byte Ptr)
	Method ClearUnorderedAccessViewFloat(pUnorderedAccessView:ID3D11UnorderedAccessView,Values:Byte Ptr)
	Method ClearDepthStencilView(pDepthStencilView:ID3D11DepthStencilView,ClearFlags,Depth#,Stencil)
	Method GenerateMips(pShaderResouceView:ID3D11ShaderResourceView)
	Method SetResourceMinLOD(pResource:ID3D11Resource,MinLOD#)
	Method GetResourceMinLOD#(pResource:ID3D11Resource)
	Method ResolveSubresource(pDstResource:ID3D11Resource,DstSubresource,pSrcResource:ID3D11Resource,SrcSubresource,Format)
	Method ExecuteCommandList(pCommandList:ID3D11CommandList,RestoreContextState)
	Method HSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method HSSetShader(pShader:ID3D11HullShader,ppClassInstances:Byte Ptr,NumClassInstances)
	Method HSSetSamplers(StartsSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method HSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method DSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method DSSetShader(pShader:ID3D11DomainShader,ppClassInstances:Byte Ptr,NumClassInstances)
	Method DSSetSamplers(StartsSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method DSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method CSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method CSSetUnorderedAccessViews(StartSlot,NumUAVs,ppUnorderedAccessViews:Byte Ptr,pUAVInitialCounts:Byte Ptr)
	Method CSSetShader(pShader:ID3D11ComputeShader,ppClassInstances:Byte Ptr)
	Method CSSetSamplers(StartsSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method CSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method VSGetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method PSGetShaderResources(StartSlot,NumBuffers,ppShaderResourceViews:Byte Ptr)
	Method PSGetShader(ppPixelShader:ID3D11PixelShader Var,ppClassInstances:Byte Ptr,pNumClassInstances:Int Var)
	Method PSGetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method VSGetShader(ppVertexShader:ID3D11VertexShader Var,ppClassInstances:Byte Ptr,pNumClassInstances:Int Var)
	Method PSGetConstantBuffers(StartSlot,NumBuffers,ppConstantBufferS:Byte Ptr)
	Method IAGetInputLayout(ppInputLayout:ID3D11InputLayout Var)
	Method IAGetVertexBuffers(StartSlot,NumBuffers,ppVertexBuffers:Byte Ptr,pStrides:Byte Ptr,pOffsets:Byte Ptr)
	Method IAGetIndexBuffer(pIndexBuffer:ID3D11Buffer Var,Format,Offset)
	Method GSGetConstantBuffers(StartSlot,NumBuffers,ppConstantBufferS:Byte Ptr)
	Method GSGetShader(ppGeometryShader:ID3D11GeometryShader Var,ppClassInstances:Byte Ptr,pNumClassInsstances:Byte Ptr)
	Method IAGetPrimitiveTopology(pTopology:Int Var)
	Method VSGetShaderResources(StartSlot,NumBuffers,ppShaderResourceViews:Byte Ptr)
	Method VSGetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method GetPredication(ppPredicate:ID3D11Predicate Var,pPredicateValue:Int Var)
	Method GSGetShaderResources(StartSlot,NumBuffers,ppShaderResourceViews:Byte Ptr)
	Method GSGetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method OMGetRenderTargets(NumViews,ppRenderTargetViews:Byte Ptr,ppDepthStencilView:Byte Ptr)
	Method OMGetRenderTargetsAndUnorderedAccessViews(NumViews,ppRenderTargetViews:Byte Ptr,ppDepthStencilView:ID3D11DepthStencilView,UAVStartSlot,NumUAVs,ppUnorderedAccessViews:Byte Ptr)
	Method OMGetBlendState(ppBlendState:ID3D11BlendState Var,BlendFactor:Byte Ptr,pSampleMask:Int Var)
	Method OMGetDepthStencilState(ppDepthStencilState:ID3D11DepthStencilState Var,pStencilRef:Int Var)
	Method SOGetTargets(NumBuffers,ppSOTargets:Byte Ptr)
	Method RSGetState(ppRasterizerState:ID3D11RasterizerState Var)
	Method RSGetViewports(pNumViewports:Int Var,pViewports:Byte Ptr)
	Method RSGetScissorRects(pNumRects:Int Var,pRects:Byte Ptr)
	Method HSGetShaderResources(StartSlot,NumBuffers,ppShaderResourceViews:Byte Ptr)
	Method HSGetShader(ppHullShader:ID3D11HullShader Var,ppClassInstances:Byte Ptr,pNumClassInstance:Int Var)
	Method HSGetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method HSGetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method DSGetShaderResources(StartSlot,NumBuffers,ppShaderResourceViews:Byte Ptr)
	Method DSGetShader(ppDomainShader:ID3D11DomainShader Var,ppClassInstances:Byte Ptr,pNumClassInstance:Int Var)
	Method DSGetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method DSGetConstantBuffers(StartSlot,NumBuffers,ppConstantBufferS:Byte Ptr)
	Method CSGetShaderResources(StartSlot,NumBuffers,ppShaderResourceViews:Byte Ptr)
	Method CSGetUnorderedAccessViews(StartSlot,NumUAVs,ppUnorderedAccessViews:Byte Ptr)
	Method CSGetShader(ppComputeShader:ID3D11ComputeShader Var,ppClassInstances:Byte Ptr,pNumClassInstances:Int Var)
	Method CSGetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method CSGetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method ClearState()
	Method Flush()
	Method GetType()
	Method GetContextFlags()
	Method FinishCommandList(RestoreDefferedContextState,ppCommandList:ID3D11CommandList Var)
EndInterface 

Interface ID3D11Device Extends IUnknown_
	Method CreateBuffer(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppBuffer:ID3D11Buffer Var)
	Method CreateTexture1D(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppTexture1D:ID3D11Texture1D Var)
	Method CreateTexture2D(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppTexture2D:ID3D11Texture2D Var)
	Method CreateTexture3D(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppTexture3D:ID3D11Texture3D Var)
	Method CreateShaderResourceView(pResource:ID3D11Resource,pDesc:Byte Ptr,ppSRView:ID3D11ShaderResourceView Var)
	Method CreateUnorderedAccessView(pResource:ID3D11Resource,pDesc:Byte Ptr,ppUAView:ID3D11UnorderedAccessView Var)
	Method CreateRenderTargetView(pResource:ID3D11Resource,pDesc:Byte Ptr,ppRTView:ID3D11RenderTargetView Var)
	Method CreateDepthStencilView(pResource:ID3D11Resource,pDesc:Byte Ptr,ppDepthStencilView:ID3D11DepthStencilView Var)
	Method CreateInputLayout(pInputElementDescs:Byte Ptr,NumElements,pShaderBytecodeWithInputSignature:Byte Ptr,BytecodeLength,ppInputLayout:ID3D11InputLayout Var)
	Method CreateVertexShader(pShaderBytecode:Byte Ptr,BytecodeLength,pClassLinkage:ID3D11ClassLinkage,ppVertexShader:ID3D11VertexShader Var)
	Method CreateGeometryShader(pShaderByteCode:Byte Ptr,ByteCodeLength,pClassLinkage:ID3D11ClassLinkage,ppGeometryShader:ID3D11GeometryShader Var)
	Method CreateGeometryShaderWithStreamOutput(pShaderByteCode:Byte Ptr,ByteCodeLength,pSODeclarations:Byte Ptr,NumEntries,pBufferStrides:Byte Ptr,NumStrides,RasterizedStream,pClassLinkage:ID3D11ClassLinkage,ppGeometryShader:ID3D11GeometryShader Var)
	Method CreatePixelShader(pShaderBytecode:Byte Ptr,BytecodeLength,pClassLinkage:ID3D11ClassLinkage,ppPixelShader:ID3D11PixelShader Var)
	Method CreateHullShader(pShaderBytecode:Byte Ptr,BytecodeLength,pClassLinkage:ID3D11ClassLinkage,ppHullShader:ID3D11HullShader Var)
	Method CreateDomainShader(pShaderBytecode:Byte Ptr,BytecodeLength,pClassLinkage:ID3D11ClassLinkage,ppDomainShader:ID3D11DomainShader Var)
	Method CreateComputeShader(pShaderBytecode:Byte Ptr,BytecodeLength,pClassLinkage:ID3D11ClassLinkage,ppDomainShader:ID3D11ComputeShader Var)
	Method CreateClassLinkage(ppLinkage:ID3D11ClassLinkage Var)
	Method CreateBlendState(pBlendStateDesc:Byte Ptr,ppBlendState:ID3D11BlendState Var)
	Method CreateDepthStencilState(pDepthStencilDesc:Byte Ptr,ppDepthStencilState:ID3D11DepthStencilState Var)
	Method CreateRasterizerState(pRasterizerDesc:Byte Ptr,ppRasterizerState:ID3D11RasterizerState Var)
	Method CreateSamplerState(pSamplerDesc:Byte Ptr,ppSamplerState:ID3D11SamplerState Var)
	Method CreateQuery(pQueryDesc:Byte Ptr,ppQuery:ID3D11Query Var)
	Method CreatePredicate(pPredicateDesc:Byte Ptr,ppPredicate:ID3D11Predicate Var)
	Method CreateCounter(pCounterDesc:Byte Ptr,ppCounter:ID3D11Counter Var)
	Method CreateDeferredContext(ContextFlags,ppDeferredContext:ID3D11DeviceContext Var)
	Method OpenSharedResource(hResource,ReturnedInterface:Byte Ptr,ppResource:IUnknown_ Var)
	Method CheckFormatSupport(Format,pFormatSupport:Int Var)
	Method CheckMultisampleQualityLevels(Format,SampleCount,pNumQualityLevels:Int Var)
	Method CheckCounterInfo(pCounterInfo:Byte Ptr)
	Method CheckCounter(pCounterDesc:Byte Ptr,ppCounter:ID3D11Counter Var)
	Method CheckFeatureSupport(Feature,pFeatureSupportData:Byte Ptr,FeatureSupportDataSize)
	Method GetPrivateData(guid:Byte Ptr,pDataSize:Int Var,pData:Byte Ptr)
	Method SetPrivateData(guid:Byte Ptr,DataSize,pData:Byte Ptr)
	Method SetPrivateDataInterface(guid:Byte Ptr,pData:Byte Ptr)
	Method GetFeatureLevel()
	Method GetCreationFlags()
	Method GetDeviceRemovedReason()
	Method GetImmediateContext(ppImmediateContext:ID3D11DeviceContext Var)
	Method SetExceptionMode(RaiseFlags)
	Method GetExceptionMode()
EndInterface 
EndExtern

Global _d3d11:Byte Ptr = LoadLibraryW("D3D11.dll")
If Not _d3d11 Return

'Core
Global D3D11CreateDevice:Byte Ptr(pAdapter:IDXGIAdapter,DriverType,hSoftware:Byte Ptr,Flags,pFeatureLevels:Byte Ptr,Featurelevels,SDKVersion,ppDevice:ID3D11Device Var,..
			pFeatureLevel:Byte Ptr,ppImmediateContext:ID3D11DeviceContext Var)"win32"=GetProcAddress(_d3d11,"D3D11CreateDevice")
Global D3D11CreateDeviceAndSwapChain:Byte Ptr(pAdapter:IDXGIAdapter,DriverType,Software,Flags,pFeatureLevels:Byte Ptr,FeatureLevels,SDKVersion,pSwapChainDesc:Byte Ptr,..
			_pSwapChain:IDXGISwapChain Var,_ppDevice:ID3D11Device Var,pFeatureLevel:Byte Ptr,ppDeviceContext:ID3D11DeviceContext Var)"win32"=GetProcAddress(_d3d11,"D3D11CreateDeviceAndSwapChain")






