fid = fopen('.\cases.dat', 'w');          
fprintf(fid,'param DetailedOutput0:=''%s'';\nparam VI_type:= %g; \nparam M:= %g; \nparam N:= %d; \nparam tau:= %d; \nparam T:= %d; \nparam MS_max:= %d;\nparam DataType:= %d;\n', DetailedOutput, VI_type, M, N, tau, T, MS_max, DataType);

fprintf(fid,'\n\nparam NM:=');
for i=1:M
    fprintf(fid,'\n%d %g', i, NM(i));
end
fprintf(fid,';\n');

fprintf(fid,'\n\nparam p:=');
for i=1:N
    fprintf(fid,'\n%d %g', i, pp(i));
end

fprintf(fid,';\n');
fclose(fid); 