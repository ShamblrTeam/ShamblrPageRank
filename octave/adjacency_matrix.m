function B = adjtomat(filename)

mfile = fopen(filename,'r');
if ( mfile == -1 )
 disp(filename);
 error('File not found');
end;

dline = fgetl(mfile);
if (dline == -1 )
  error('Empty file.')
end

% Read through comments, ignoring them
while length(dline) > 0 && dline(1) == '%',
  dline = fgetl(mfile);
end

i=1;
while length(dline) > 0 && dline ~= -1,
  [lstr,dline]=strtok(dline);
  lnum=str2num(lstr);
  if isempty(dline)
    % make sure matrix has correct size
    a(i,1)=lnum;
    a(i,2)=1;
    a(i,3)=0;
    i=i+1;
  end
  while ~isempty(dline)
    [cstr,dline]=strtok(dline);
    a(i,1)=lnum;
    a(i,2)=str2num(cstr);
    a(i,3)=1;
    i=i+1;
  end
  dline = fgetl(mfile);
end

B=spconvert(a);

fclose(mfile);