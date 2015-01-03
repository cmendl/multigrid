function options = processopts(defopts,varargin)
%
% options = processopts(varargin)
%
%	Process options in the form ('param',value)
%
%	Input:		defopts			default options
%				varargin		'param', value, ...
%
%	Output:		options			options structure

% default options
options = defopts;

% iterate through arguments
while ~isempty(varargin)
	if isfield(options,varargin{1})
		options.(varargin{1}) = varargin{2};
	else
		warning('Unrecognized option ''%s''',varargin{1});
	end
	varargin = varargin(3:end);
end
