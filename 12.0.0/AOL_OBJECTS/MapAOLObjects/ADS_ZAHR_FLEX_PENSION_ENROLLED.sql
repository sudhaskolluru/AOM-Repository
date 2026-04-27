  CREATE OR REPLACE EDITIONABLE FUNCTION "ADS_ZAHR_FLEX_PENSION_ENROLLED" (p_assignment_id IN NUMBER,
	   	  		  		   						 p_business_group_id IN NUMBER,
												 p_effective_date IN DATE
												 ) RETURN VARCHAR2 IS
--
CURSOR c_pen IS
SELECT 'Y'
FROM ben_prtt_enrt_rslt_f pen
, ben_per_in_ler pil
, per_all_assignments_f asg
WHERE pen.pl_id = 2009 -- pl_id of pension
AND OIPL_ID = 2480 -- option in plan id of amount
-- and pil.ler_id = p_ler_id
AND pil.per_in_ler_stat_cd = 'STRTD'
AND asg.assignment_id = p_assignment_id
AND pil.per_in_ler_id = pen.per_in_ler_id
AND pen.effective_end_date = TO_DATE('31-dec-4712')
AND (pen.enrt_cvg_thru_dt IS NULL OR
	pen.enrt_cvg_thru_dt = TO_DATE('31-dec-4712'))
AND pen.business_group_id = p_business_group_id
AND asg.person_id = pil.person_id
AND p_effective_date BETWEEN asg.effective_start_date AND asg.effective_end_date
AND p_effective_date BETWEEN pen.effective_start_date AND pen.effective_end_date;
--
CURSOR c_prov IS
SELECT 'Y'
FROM ben_prtt_enrt_rslt_f pen
, ben_per_in_ler pil
, per_all_assignments_f asg
WHERE pen.pl_id = 2011 -- pl_id of provident
AND OIPL_ID = 2465 -- option in plan id of amount
-- and pil.ler_id = p_ler_id
AND pil.per_in_ler_stat_cd = 'STRTD'
AND asg.assignment_id = p_assignment_id
AND pil.per_in_ler_id = pen.per_in_ler_id
AND pen.effective_end_date = TO_DATE('31-dec-4712')
AND (pen.enrt_cvg_thru_dt IS NULL OR
	pen.enrt_cvg_thru_dt = TO_DATE('31-dec-4712'))
AND pen.business_group_id = p_business_group_id
AND asg.person_id = pil.person_id
AND p_effective_date BETWEEN asg.effective_start_date AND asg.effective_end_date
AND p_effective_date BETWEEN pen.effective_start_date AND pen.effective_end_date;
--				
l_result VARCHAR2(100) := 'N';
l_result1 VARCHAR2(100) := 'N';
--
BEGIN
--
OPEN c_pen;
FETCH c_pen INTO l_result;
CLOSE c_pen;
--
OPEN c_prov;
FETCH c_prov INTO l_result1;
CLOSE c_prov;
--
IF l_result = 'Y'
AND l_result1 = 'Y'
THEN
RETURN 'N';
ELSE
RETURN 'Y';
END IF;
-- -- end chk_emp_life_enrld;
END;
/
