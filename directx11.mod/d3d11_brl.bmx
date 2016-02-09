Strict 

Import Pub.Win32

Import "DXGI_brl.bmx"
Import "d3dcommon_brl.bmx"
Import "d3d11_common.bmx"


Extern"win32"

Type ID3D11DeviceChild Extends IUnknown
	Method GetDevice()
	Method GetPrivateData()
	Method SetPrivateData()
	Method SetPrivateDataInterface()
EndType

Type ID3D11DepthStencilState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11BlendState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11RasterizerState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Resource Extends ID3D11DeviceChild
	Method GetType()
	Method SetEvictionPriority()
	Method GetEvictionPriority()
EndType

Type ID3D11Buffer Extends ID3D11Resource
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Texture1D Extends ID3D11Resource
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Texture2D Extends ID3D11Resource	
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Texture3D Extends ID3D11Resource
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11View Extends ID3D11DeviceChild
	Method GetResource(ppResource:ID3D11Resource Var)
EndType

Type ID3D11ShaderResourceView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11RenderTargetView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11DepthStencilView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11UnorderedAccessView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11VertexShader Extends ID3D11DeviceChild
EndType

Type ID3D11HullShader Extends ID3D11DeviceChild
EndType

Type ID3D11DomainShader Extends ID3D11DeviceChild
EndType

Type ID3D11GeometryShader Extends ID3D11DeviceChild
EndType

Type ID3D11PixelShader Extends ID3D11DeviceChild
EndType

Type ID3D11ComputeShader Extends ID3D11DeviceChild
EndType

Type ID3D11InputLayout Extends ID3D11DeviceChild
EndType

Type ID3D11SamplerState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Asynchronous Extends ID3D11DeviceChild
	Method GetDataSize()
EndType

Type ID3D11Query Extends ID3D11Asynchronous
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Predicate Extends ID3D11Query
EndType

Type ID3D11Counter Extends ID3D11Asynchronous
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11ClassInstance Extends ID3D11DeviceChild
	Method GetClassLinkage(ppLinkage:ID3D11ClassLinkage Var)
	Method GetDesc(pDesc:Byte Ptr)
	Method GetInstanceName(pInstanceName:Byte Ptr,pBufferLength)
	Method GetTypeName(pTypeName:Byte Ptr,pBufferLength)
EndType

Type ID3D11ClassLinkage Extends ID3D11DeviceChild
	Method GetClassInstance(pClassInstanceName:Byte Ptr,InstanceIndex,ppInstance:ID3D11ClassInstance Var)
	Method CreateClassInstance(pszClassTypeName:Byte,ConstantBufferOffset,ConstantVectorOffset,TextureOffset,SamplerOffset,ppInstsance:ID3D11ClassInstance Var)
EndType

Type ID3D11CommandList Extends ID3D11DeviceChild
	Method GetContextFlags()
EndType

Type ID3D11DeviceContext Extends ID3D11DeviceChild
	Method VSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method PSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method PSSetShader(pPixelShader:Byte Ptr,ppClassInstances:Byte Ptr,NumClassInstances)
	Method PSSetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method VSSetShader(pVertexShader:Byte Ptr,ppClassInstances:Byte Ptr,NumClassInstances)
	Method DrawIndexed(IndexCount,StartIndexLocation,BaseVertexLocation)
	Method Draw(VertexCount,StartVertexLocation)
	Method Map(pResource:Byte Ptr,Subresource,MapType,MapFlags,pMappedResource:Byte Ptr)
	Method UnMap(pResource:Byte Ptr,Subresource)
	Method PSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method IASetInputLayout(pInputLayout:Byte Ptr)
	Method IASetVertexBuffers(StartSlot,NumBuffers,ppVertexBuffers:Byte Ptr,pStrides:Byte Ptr,pOffsets:Byte Ptr)
	Method IASetIndexBuffer(pIndexBuffer:Byte Ptr,Format,Offset)
	Method DrawIndexedInstanced(IndexCountPerInstance,InstanceCount,StartIndexLocation,BaseVertexLocation,StartInstanceLocation)
	Method DrawInstanced(VertexCountPerInstance,InstanceCount,StartVertexLocation,StartInstanceLocation)
	Method GSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method GSSetShader(pShader:Byte Ptr,ppClassInstance:Byte Ptr,NumClassInstances)
	Method IASetPrimitiveTopology(Topology)
	Method VSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method VSSetSamplers(StartSlot,NumSamplers,ppSampelers:Byte Ptr)
	Method Begin(pAsync:Byte Ptr)
	Method End_(pAsync:Byte Ptr)
	Method GetData(pAsync:Byte Ptr,pData:Byte Ptr,DataSize,GetDataFlags)
	Method SetPredication(pPredicate:Byte Ptr,PredicateValue)
	Method GSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method GSSetSamplers(StartSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method OMSetRenderTargets(NumViews,ppRenderTargetViews:Byte Ptr,pDepthStencilView:Byte Ptr)
	Method OMSetRendetTargetsAndUnorderedAccessViews(NumViews,ppRenderTargetViews:Byte Ptr,ppDepthStencilView:ID3D11DepthStencilView Var,UAVStartSlot,NumUAVs,ppUnorderedAccessViews:Byte Ptr)
	Method OMSetBlendState(pBlendState:Byte Ptr,BlendFactor:Byte Ptr,SampleMask)
	Method OMSetDepthStencilState(pDepthStencilState:Byte Ptr,StencilRef)
	Method SOSetTargets(NumBuffers,ppSOTargets:Byte Ptr,pOffsets:Byte Ptr)
	Method DrawAuto()
	Method DrawIndexedInstancedIndirect(pBufferForArgs:Byte Ptr,AlignedByteOffsetForArgs)
	Method DrawInstancedIndirect(pBufferForArgs:Byte Ptr,AlignedByteOffsetForArgs)
	Method Dispatch(ThreadGroupCountX,ThreadGroupCountY,ThreadCountZ)
	Method DispatchIndirect(pBufferForArgs:Byte Ptr,AlignedOffsetForArgs)
	Method RSSetState(pRasterizerState:Byte Ptr)
	Method RSSetViewports(NumViewports,pViewports:Byte Ptr)
	Method RSSetScissorRects(NumRects,pRects:Byte Ptr)
	Method CopySubresourceRegion(pDstResource:Byte Ptr,DstSubresource,DstX,DstY,DstZ,pSrcResource:Byte Ptr,SrcSubresource,pSrcBox:Byte Ptr)
	Method CopyResource(pDstResource:Byte Ptr,pSrcResource:Byte Ptr)
	Method UpdateSubresource(pDstResource:Byte Ptr,DstSubresource,pDstBox:Byte Ptr,pSrcData:Byte Ptr,SrcRowPitch,SrcDepthPitch)
	Method CopyStructureCount(pDstBuffer:Byte Ptr,DstAlignedByteOffset,pSrcView:Byte Ptr)
	Method ClearRenderTargetView(pRenderTargetView:Byte Ptr,ColorRGBA:Byte Ptr)
	Method ClearUnorderedAccessViewUint(pUnorderedAccessView:Byte Ptr,Values:Byte Ptr)
	Method ClearUnorderedAccessViewFloat(pUnorderedAccessView:Byte Ptr,Values:Byte Ptr)
	Method ClearDepthStencilView(pDepthStencilView:Byte Ptr,ClearFlags,Depth#,Stencil)
	Method GenerateMips(pShaderResouceView:Byte Ptr)
	Method SetResourceMinLOD(pResource:Byte Ptr,MinLOD#)
	Method GetResourceMinLOD#(pResource:Byte Ptr)
	Method ResolveSubresource(pDstResource:Byte Ptr,DstSubresource,pSrcResource,SrcSubresource,Format)
	Method ExecuteCommandList(pCommandList:Byte Ptr,RestoreContextState)
	Method HSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method HSSetShader(pShader:Byte Ptr,ppClassInstances:Byte Ptr,NumClassInstances)
	Method HSSetSamplers(StartsSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method HSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method DSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method DSSetShader(pShader:Byte Ptr,ppClassInstances:Byte Ptr,NumClassInstances)
	Method DSSetSamplers(StartsSlot,NumSamplers,ppSamplers:Byte Ptr)
	Method DSSetConstantBuffers(StartSlot,NumBuffers,ppConstantBuffers:Byte Ptr)
	Method CSSetShaderResources(StartSlot,NumViews,ppShaderResourceViews:Byte Ptr)
	Method CSSetUnorderedAccessViews(StartSlot,NumUAVs,ppUnorderedAccessViews:Byte Ptr,pUAVInitialCounts:Byte Ptr)
	Method CSSetShader(StartsSlot,NumSamplers,ppSamplers:Byte Ptr)
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
EndType

Type ID3D11Device Extends IUnknown
	Method CreateBuffer(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppBuffer:ID3D11Buffer Var)
	Method CreateTexture1D(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppTexture1D:ID3D11Texture1D Var)
	Method CreateTexture2D(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppTexture2D:ID3D11Texture2D Var)
	Method CreateTexture3D(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppTexture3D:ID3D11Texture3D Var)
	Method CreateShaderResourceView(pResource:Byte Ptr,pDesc:Byte Ptr,ppSRView:ID3D11ShaderResourceView Var)
	Method CreateUnorderedAccessView(pResource:Byte Ptr,pDesc:Byte Ptr,ppUAView:ID3D11UnorderedAccessView Var)
	Method CreateRenderTargetView(pResource:Byte Ptr,pDesc:Byte Ptr,ppRTView:ID3D11RenderTargetView Var)
	Method CreateDepthStencilView(pResource:Byte Ptr,pDesc:Byte Ptr,ppDepthStencilView:ID3D11DepthStencilView Var)
	Method CreateInputLayout(pInputElementDescs:Byte Ptr,NumElements,pShaderBytecodeWithInputSignature:Byte Ptr,BytecodeLength,ppInputLayout:ID3D11InputLayout Var)
	Method CreateVertexShader(pShaderBytecode:Byte Ptr,BytecodeLength,pClassLinkage:Byte Ptr,ppVertexShader:ID3D11VertexShader Var)
	Method CreateGeometryShader(pShaderByteCode:Byte Ptr,ByteCodeLength,pClassLinkage:Byte Ptr,ppGeometryShader:ID3D11GeometryShader Var)
	Method CreateGeometryShaderWithStreamOutput(pShaderByteCode:Byte Ptr,ByteCodeLength,pSODeclarations:Byte Ptr,NumEntries,pBufferStrides:Byte Ptr,NumStrides,RasterizedStream,pClassLinkage:Byte Ptr,ppGeometryShader:ID3D11GeometryShader Var)
	Method CreatePixelShader(pShaderBytecode:Byte Ptr,BytecodeLength,pClassLinkage:Byte Ptr,ppPixelShader:ID3D11PixelShader Var)
	Method CreateHullShader(pShaderBytecode:Byte Ptr,BytecodeLength,pClassLinkage:Byte Ptr,ppHullShader:ID3D11HullShader Var)
	Method CreateDomainShader(pShaderBytecode:Byte Ptr,BytecodeLength,pClassLinkage:Byte Ptr,ppDomainShader:ID3D11DomainShader Var)
	Method CreateComputeShader(pShaderBytecode:Byte Ptr,BytecodeLength,pClassLinkage:Byte Ptr,ppDomainShader:ID3D11ComputeShader Var)
	Method CreateClassLinkage(ppLinkage:ID3D11ClassLinkage Var)
	Method CreateBlendState(pBlendStateDesc:Byte Ptr,ppBlendState:ID3D11BlendState Var)
	Method CreateDepthStencilState(pDepthStencilDesc:Byte Ptr,ppDepthStencilState:ID3D11DepthStencilState Var)
	Method CreateRasterizerState(pRasterizerDesc:Byte Ptr,ppRasterizerState:ID3D11RasterizerState Var)
	Method CreateSamplerState(pSamplerDesc:Byte Ptr,ppSamplerState:ID3D11SamplerState Var)
	Method CreateQuery(pQueryDesc:Byte Ptr,ppQuery:ID3D11Query Var)
	Method CreatePredicate(pPredicateDesc:Byte Ptr,ppPredicate:ID3D11Predicate Var)
	Method CreateCounter(pCounterDesc:Byte Ptr,ppCounter:ID3D11Counter Var)
	Method CreateDeferredContext(ContextFlags,ppDeferredContext:ID3D11DeviceContext Var)
	Method OpenSharedResource(hResource,ReturnedInterface:Byte Ptr,ppResource:IUnknown Var)
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
EndType
EndExtern

Global _d3d11 = LoadLibraryA("D3D11.dll")

If Not _d3d11 Return

'Core
Global D3D11CreateDevice(pAdapter:Byte Ptr,DriverType,Software,Flags,pFeatureLevels:Byte Ptr,Featurelevels,SDKVersion,ppDevice:ID3D11Device Var,..
			pFeatureLevel:Byte Ptr,ppImmediateContext:ID3D11DeviceContext Var)"win32"=GetProcAddress(_d3d11,"D3D11CreateDevice")
Global D3D11CreateDeviceAndSwapChain(pAdapter:Byte Ptr,DriverType,Software,Flags,pFeatureLevels:Byte Ptr,FeatureLevels,SDKVersion,pSwapChainDesc:Byte Ptr,..
			_pSwapChain:IDXGISwapChain Var,_ppDevice:ID3D11Device Var,pFeatureLevel:Byte Ptr,ppDeviceContext:ID3D11DeviceContext Var)"win32"=GetProcAddress(_d3d11,"D3D11CreateDeviceAndSwapChain")
